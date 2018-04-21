extends Node
    

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    var NUM_CREW = 8
    # Get array of crew names, not allowing empty lines
    var crew_name_file = File.new()
    # var am_i_mad = crew_name_file.file_exists("res://crewmen/crewnames.txt")
    crew_name_file.open("res://crewmen/crewnames.txt", crew_name_file.READ)
    var crew_name_pool = crew_name_file.get_as_text()
    crew_name_pool = crew_name_pool.split("\n", false)
    crew_name_file.close()
    
    for crew_id in range(NUM_CREW):
        var crewman = get_node("Crewman%s" % crew_id)
        var name_ind = randi() % crew_name_pool.size()
        crewman.crew_name = crew_name_pool[name_ind]
        crew_name_pool.remove(name_ind)
    
    var x  = 0
#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass
