extends Area2D

# Class consts
const CREW_SPEED = 200
const HEALING_RATE = 10

# Useful enums and arrays
enum crew_state {IDLE, MOVING, ACTING, TALKING}
enum room_action {PUMPING, HEALING}
var active_rooms = [
    Globals.Rooms.MedBay,
    Globals.Rooms.PumpRoom
]

# Each crewman has a name, and is the traitor or not
var crew_name = null
var traitor = false
var hitpoints = 100
var happiness = 1.0

# Current state info
var state = crew_state.IDLE
var current_room = null
var destination = null
var idle_time = 0.0

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    # get_node("../Submarine")
    pass

func _process(delta):
    # Get an instance of the Submarine node
    var sub = get_node("/root/Main/Submarine")
    
    # Update the current room
    current_room = sub.containing_room_id(position)
    
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
            elif mov_vect.length() <= (CREW_SPEED * delta):
                self.position.x += mov_vect.x
                self.position.y += mov_vect.y

            # Move the direction of the vector, as far as we can.
            else:
                self.position.x += (mov_vect.normalized() * delta).x
                self.position.y += (mov_vect.normalized() * delta).y

        # Handle the possible states of the current room
        crew_state.ACTING:
            idle_time = 0.0
            if sub.room(current_room).flooding():
                # Flooding can only be fixed from the pump room
                destination = Globals.Rooms.PumpRoom
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
                    hitpoints += HEALING_RATE * delta
                    if hitpoints > 100:
                        hitpoints = 100
                        state = crew_state.IDLE
                else:
                    state = crew_state.IDLE
            
            # Go to idle if nothing else to do
            else:
                state = crew_state.IDLE

        crew_state.IDLE:
            # Go to MedBay if injured
            if hitpoints < 100:
                idle_time = 0.0
                destination = Globals.Rooms.Medbay
                state = crew_state.MOVING
            
            # Otherwise, wait for a random short time, then go to random room
            else:
                if not idle_time:
                    idle_time = randi() % 7  + 3
                else:
                    idle_time -= delta
                    if idle_time <= 0:
                        idle_time = 0
                        destination = Globals.ROOMS_LIST[randi() % 8]
                        state = crew_state.MOVING
