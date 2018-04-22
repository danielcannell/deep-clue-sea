extends KinematicBody2D

# Member variables
const GRAVITY = 1000.0 # pixels/second/second

const JUMP_SPEED = 200
const JUMP_MAX_AIRBORNE_TIME = 0.2

const WALK_SPEED = 200
const CLIMB_SPEED = 200

const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false

var is_on_ladder = 0
var in_dialog = false

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass

func _physics_process(delta):
    # Create forces
    var force = Vector2(0, GRAVITY)

    var walk_left = Input.is_action_pressed("move_left")
    var walk_right = Input.is_action_pressed("move_right")
    var climb_up = Input.is_action_pressed("move_up")
    var climb_down = Input.is_action_pressed("move_down")
    var jump = Input.is_action_just_pressed("jump")

    if is_on_ladder > 0:
        force.y = 0
        velocity.y = 0
        if climb_up:
            velocity.y = -CLIMB_SPEED
        elif climb_down:
            velocity.y = CLIMB_SPEED

    if walk_left:
        velocity.x = -WALK_SPEED
    elif walk_right:
        velocity.x = WALK_SPEED
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

    if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not jumping:
        # Jump must also be allowed to happen if the character left the floor a little bit ago.
        # Makes controls more snappy.
        velocity.y = -JUMP_SPEED
        jumping = true

    on_air_time += delta

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
