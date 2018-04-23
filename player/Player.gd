extends KinematicBody2D

# Member variables
var velocity = Vector2()
var on_air_time = 100
var jumping = false

var is_on_ladder = 0
var in_dialog = false

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass

func update_animation():
    var anim = get_node("AnimatedSprite")
    if is_on_ladder:
        anim.animation = "updown"
        anim.flip_h = false
        anim.playing = velocity.length() > 0
    elif velocity.length() == 0:
        anim.animation = "idle"
        anim.flip_h = false
    elif velocity.x > 0:
        anim.animation = "right"
        anim.flip_h = false
    elif velocity.x < 0:
        anim.animation = "right"
        anim.flip_h = true

func _physics_process(delta):
    # Create forces
    var force = Vector2(0, Globals.GRAVITY)

    var walk_left = Input.is_action_pressed("move_left")
    var walk_right = Input.is_action_pressed("move_right")
    var climb_up = Input.is_action_pressed("move_up")
    var climb_down = Input.is_action_pressed("move_down")
    var jump = Input.is_action_just_pressed("jump")

    if is_on_ladder > 0:
        force.y = 0
        velocity.y = 0
        if climb_up:
            velocity.y = -Globals.PLAYER_CLIMB_SPEED
        elif climb_down:
            velocity.y = Globals.PLAYER_CLIMB_SPEED

    if walk_left:
        velocity.x = -Globals.PLAYER_WALK_SPEED
    elif walk_right:
        velocity.x = Globals.PLAYER_WALK_SPEED
    else:
        velocity.x = 0

    # Integrate forces to velocity
    velocity += force * delta
    
    if in_dialog:
        velocity = Vector2()
    
    # Integrate velocity into motion and move
    velocity = move_and_slide(velocity, Vector2(0, -1))

    if is_on_floor():
        on_air_time = 0

    if jumping and velocity.y >= 0:
        # If falling, no longer jumping
        jumping = false

    if on_air_time < Globals.PLAYER_JUMP_MAX_AIRBORNE_TIME and jump and not jumping:
        # Jump must also be allowed to happen if the character left the floor a little bit ago.
        # Makes controls more snappy.
        velocity.y = -Globals.PLAYER_JUMP_SPEED
        jumping = true

    on_air_time += delta

    update_animation()

func _on_Area2D_area_entered(area):
    if area.get_name() == "ladder":
        is_on_ladder += 1

func _on_Area2D_area_exited(area):
    if area.get_name() == "ladder":
        is_on_ladder -= 1

func start_dialog():
    in_dialog = true

func end_dialog():
    in_dialog = false
