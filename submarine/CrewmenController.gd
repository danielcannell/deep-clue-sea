extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var crewmen = []
var selected_crewman = null
var crewman_names = []

func _ready():
    crewmen = get_children()
    assign_names(crewmen)
    
    for c in crewmen:
        c.connect("clicked", self, "crewman_clicked")

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

func assign_names(crewmen):
    # Get array of crew names, not allowing empty lines
    var crew_name_file = File.new()
    crew_name_file.open("res://crewmen/crewnames.txt", crew_name_file.READ)
    var crew_name_pool = crew_name_file.get_as_text()
    crew_name_pool = crew_name_pool.split("\n", false)
    crew_name_file.close()
    
    # Assign each crew member a random name
    for c in crewmen:
        var name_ind = randi() % crew_name_pool.size()
        c.crew_name = crew_name_pool[name_ind]
        crewman_names.append(crew_name_pool[name_ind])
        crew_name_pool.remove(name_ind)

func crewman_clicked(c):
    if selected_crewman:
        selected_crewman.deselect()
    selected_crewman = c
    selected_crewman.select()

func command_to_room(room):
    if selected_crewman:
        selected_crewman.command_to_room(room)

func can_interact(player_pos):
    if selected_crewman:
        return player_pos.distance_to(selected_crewman.position + position) < Globals.INTERACTRION_DISTANCE
    return false
    
func selected_crewman_id():
    return crewmen.find(selected_crewman)