extends Area2D

# Class consts all in globals as settings...

# Useful enums and arrays
enum crew_state {IDLE, MOVING, ACTING, TALKING, DEAD, DIALOG}
enum room_action {PUMPING, HEALING}
var active_rooms = [
    Globals.Rooms.MedBay,
    Globals.Rooms.PumpRoom
]

signal clicked(c)

# Each crewman has a name, and is the traitor or not
var crew_name = null setget set_crewname
var traitor = false
var hitpoints = Globals.CREW_MAX_HITPOINTS
var happiness = 1.0
var room_knowledge = []
var traitor_knowledge = []

# Current state info
var state = crew_state.IDLE
var current_room = null
var destination = null
var idle_time = 0.0
var last_dialog_time = -INF

var enquired_crew = []
var enquired_rooms = []

var sub = null

var selected = false

signal hitpoints_update

func _input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.pressed:
            emit_signal("clicked", self)

func _ready():
    deselect()

func set_crewname(txt):
    crew_name = txt
    get_node("Nameplate").text = txt

func get_random_pos_in_room(room):
    return room.centre_position() + Vector2(rand_range(-85, 85), 0)

func command_to_room(room):
    if state != crew_state.DEAD:
        if sub.room(sub.containing_room_id(position)) == room:
            state = crew_state.ACTING
        else:
            state = crew_state.MOVING
            destination = get_random_pos_in_room(room)

func _process(delta):
    # Get an instance of the Submarine node
    sub = get_node("/root/Main/Submarine")
    
    # Update the current room
    current_room = sub.containing_room_id(position)
    hitpoints -= (sub.room(current_room).fire() * Globals.FIRE_DAMAGE_RATE * delta)
    if sub.room(current_room).flooding() > 0.7:
        hitpoints -= Globals.DROWNING_DAMAGE_RATE * delta
    var current_speed = ((1 - sub.room(current_room).flooding() * Globals.FLOODED_MAX_SPEED) * Globals.CREW_SPEED)
    
    if hitpoints <= 0 and state != crew_state.DEAD:
        state = crew_state.DEAD
        rotation = PI / 2
        position.y -= 15
    
    # Act based on current state
    match state:
        
        crew_state.MOVING:
            idle_time = 0.0
            # Get a vector towards destination
            var mov_vect = get_node("PathPlanner").get_path_vector(position, destination)
            # Length 0: We've arrived or path is blocked
            # See what there is to do where we are
            if mov_vect.length() == 0:
                state = crew_state.ACTING

            # We're close to destination. Move the whole vector distance.
            elif mov_vect.length() <= (current_speed * delta):
                position.x += mov_vect.x
                position.y += mov_vect.y

            # Move the direction of the vector, as far as we can.
            else:
                position.x += (mov_vect.normalized() * current_speed * delta).x
                position.y += (mov_vect.normalized() * current_speed * delta).y

        # Handle the possible states of the current room
        crew_state.ACTING:
            idle_time = 0.0
            if sub.room(current_room).flooding():
                # Flooding can only be fixed from the pump room
                destination = get_random_pos_in_room(sub.room(Globals.Rooms.PumpRoom))
                state = crew_state.MOVING

            elif sub.room(current_room).fire():
                var extinguished = sub.room(current_room).extinguish_fire()
                if extinguished:
                    state = crew_state.IDLE

            elif current_room == Globals.Rooms.PumpRoom:
                var flood_clear = true
                
                # Pump out all rooms
                for room in Globals.ROOMS_LIST:
                    flood_clear = flood_clear && sub.room(room).drain_flooding()
                if flood_clear:
                    state = crew_state.IDLE
            
            # Heal if necessary
            elif current_room == Globals.Rooms.MedBay:
                if hitpoints < 100:
                    hitpoints += Globals.HEALING_RATE * delta
                    if hitpoints > 100:
                        hitpoints = 100
                        state = crew_state.IDLE
                else:
                    state = crew_state.IDLE
            
            # Go to idle if nothing else to do
            else:
                state = crew_state.IDLE

        crew_state.IDLE:
            # Go to MedBay if badly injured
            if hitpoints < Globals.CREW_MAX_HITPOINTS / 2:
                idle_time = 0.0
                destination = get_random_pos_in_room(sub.room(Globals.Rooms.MedBay))
                state = crew_state.MOVING
            
            # Otherwise, wait for a random short time, then go to random room
            else:
                if not idle_time:
                    idle_time = randi() % 7  + 3
                else:
                    idle_time -= delta
                    if idle_time <= 0:
                        idle_time = 0
                        destination = get_random_pos_in_room(sub.room(Globals.ROOMS_LIST[randi() % 8]))
                        state = crew_state.MOVING

        crew_state.DEAD:
            hitpoints = 0

    emit_signal("hitpoints_update", hitpoints)

func is_alive():
    return state != crew_state.DEAD

func select():
    selected = true
    get_node("Line2D").set_default_color(Color(0.2, 1.0, 0.2, 1.0))

func deselect():
    selected = false
    get_node("Line2D").set_default_color(Color(0.0, 0.0, 0.0, 0.0))

func start_dialog():
    state = crew_state.DIALOG

func end_dialog():
    state = crew_state.IDLE
