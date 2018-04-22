extends Node

var RoomSolText = {
    Globals.Rooms.EngineRoom: "",
    Globals.Rooms.Instrumentation: "",
    Globals.Rooms.WeaponControl: "",
    Globals.Rooms.LifeSupport: "",
    Globals.Rooms.PumpRoom: "",
    Globals.Rooms.MedBay: "",
    Globals.Rooms.Bridge: ""
}

var solution = {"location":null, "traitor":null}


func _ready():
    # Get array of crew names, not allowing empty lines
    var crew_name_file = File.new()
    crew_name_file.open("res://crewmen/crewnames.txt", crew_name_file.READ)
    var crew_name_pool = crew_name_file.get_as_text()
    crew_name_pool = crew_name_pool.split("\n", false)
    crew_name_file.close()
    
    # Necessary later for assigning knowledge around
    var not_solution_name_list = []

    # Assign each crew member a random name
    for crew_id in range(Globals.NUM_CREW):
        var crewman = get_node("root/Main/Submarine/CrewController/Crewman%s" % crew_id)
        var name_ind = randi() % crew_name_pool.size()
        crewman.crew_name = crew_name_pool[name_ind]
        not_solution_name_list.append(crew_name_pool[name_ind])
        crew_name_pool.remove(name_ind)
    
    # Pick a random crewman to be traitor
    var traitor = get_node("root/Main/Submarine/CrewController/Crewman%s" % (randi() % Globals.NUM_CREW))
    solution["traitor"] = traitor
    solution["traitor"].traitor = true
    not_solution_name_list.erase(traitor.crew_name)
    
    # Randomly select a room to be the correct solution
    solution["location"] = Globals.Rooms[randi() % 8]
    var not_solution_rooms_list = Globals.Rooms.duplicate(true).erase(solution["location"])

    # Assign knowledge around
    # Generate correct amount of knowledge
    var not_guilty_crew = not_solution_name_list.length()
    for i in range(not_guilty_crew):
        for j in range(Globals.TRAITOR_KNOWLEDGE_COUNT - 1):
            not_solution_name_list.append(not_solution_name_list[i])
    
    var not_solution_rooms = not_solution_rooms_list.length()
    for i in range(not_solution_rooms):
        for j in range(Globals.ROOM_KNOWLEDGE_COUNT - 1):
            not_solution_rooms_list.append(not_solution_rooms_list[i])
    
    not_solution_rooms = not_solution_rooms_list.length()
    not_guilty_crew = not_solution_name_list.length()
    var i = 0
    for room_knl in range(not_solution_rooms):
        var crew = get_node("root/Main/Submarine/CrewController/Crewman%s" % (i % Globals.NUM_CREW))
        var knl_item = randi() % not_solution_rooms_list.length()
        crew.room_knowledge.append(not_solution_rooms[knl_item])
        not_solution_rooms_list.remove(knl_item)
        i += 1
    
    for traitor_knl in range(not_guilty_crew):
        var crew = get_node("root/Main/Submarine/CrewController/Crewman%s" % (i % Globals.NUM_CREW))
        var knl_item = randi() % not_solution_name_list.length()
        crew.room_knowledge.append(not_guilty_crew[knl_item])
        not_solution_name_list.remove(knl_item)
        i += 1

    
