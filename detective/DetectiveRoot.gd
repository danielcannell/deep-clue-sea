extends Node
    
var solution = {"location":null, "traitor":null}


func _ready():
    # NUM_CREW must be the same as the number of crewman nodes
    var NUM_CREW = 8
    
    # Get array of crew names, not allowing empty lines
    var crew_name_file = File.new()
    crew_name_file.open("res://crewmen/crewnames.txt", crew_name_file.READ)
    var crew_name_pool = crew_name_file.get_as_text()
    crew_name_pool = crew_name_pool.split("\n", false)
    crew_name_file.close()
    
    # Assign each crew member a random name
    for crew_id in range(NUM_CREW):
        var crewman = get_node("Crewman%s" % crew_id)
        var name_ind = randi() % crew_name_pool.size()
        crewman.crew_name = crew_name_pool[name_ind]
        crew_name_pool.remove(name_ind)
    
    # Pick a random crewman to be traitor
    solution["traitor"] = get_node("Crewman%s" % (randi() % NUM_CREW))
    solution["traitor"].traitor = true
    
    # Randomly select a room to be the correct solution
    var rooms_file = File.new()
    rooms_file.open("res://submarine/rooms.txt", rooms_file.READ)
    var rooms = rooms_file.get_as_text().split("\n", false)
    rooms_file.close()
    
    solution["location"] = rooms[randi() % 8]    
    

