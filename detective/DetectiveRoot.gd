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
var crew_knowledge = []

func _ready():
    var num_crew = get_node("/root/Main/Submarine/CrewmenController").crewmen.size()
    for i in range(num_crew):
        crew_knowledge.append({"room_knowledge": [], "people_knowledge": []})
    # Randomly select a room to be the correct solution
    solution["location"] = Globals.ROOMS_LIST[randi() % 8]
    var not_solution_rooms_list = Globals.ROOMS_LIST.duplicate()
    not_solution_rooms_list.erase(solution["location"])
    
    # Randomly select a traitor from list
    solution["traitor"] = randi() % num_crew
    
    var not_solution_crew_list = []
    
    for i in range(num_crew):
        not_solution_crew_list.append(i)
    
    not_solution_crew_list.erase(solution["traitor"])
    

    # Assign knowledge around
    # Generate correct amount of knowledge
    
    var not_guilty_crew = not_solution_crew_list.size()
    for i in range(not_guilty_crew):
        for j in range(Globals.TRAITOR_KNOWLEDGE_COUNT - 1):
            not_solution_crew_list.append(not_solution_crew_list[i])
    
    var not_solution_rooms = not_solution_rooms_list.size()
    for i in range(not_solution_rooms):
        for j in range(Globals.ROOM_KNOWLEDGE_COUNT - 1):
            not_solution_rooms_list.append(not_solution_rooms_list[i])
    
    not_solution_rooms = not_solution_rooms_list.size()
    not_guilty_crew = not_solution_crew_list.size()
    var i = 0
    for room_knl in range(not_solution_rooms):
        var crew = i % num_crew
        var knl_item = randi() % not_solution_rooms_list.size()
        crew_knowledge[crew]["room_knowledge"].append(not_solution_rooms_list[knl_item])
        not_solution_rooms_list.remove(knl_item)
        i += 1
    
    for traitor_knl in range(not_guilty_crew):
        var crew = i % num_crew
        var knl_item = randi() % not_solution_crew_list.size()
        crew_knowledge[crew]["people_knowledge"].append(not_solution_crew_list[knl_item])
        not_solution_crew_list.remove(knl_item)
        i += 1

    
