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

enum DialogState {
    None,
    BuggerOff,
    Banter,
    CrewInterrogation,
    RoomInterrogation,
}

var dialog_state = DialogState.None

var solution = {"location":null, "traitor":null}
var crew_knowledge = []
var player_knowledge = {"suspects":[], "potential_locs": []}

func _ready():
    # Register for chat button clicks
    var hud = get_node("/root/Main/HUD")
    hud.connect("chat_button_pressed", self, "chat_button_pressed")

    initialise_case()
    initialise_player_knowledge()

func initialise_player_knowledge():
    var num_crew = get_node("/root/Main/Submarine/CrewmenController").crewmen.size()
    for i in range(num_crew):
        player_knowledge["suspects"].append(i)
    for room in Globals.ROOMS_LIST:
        player_knowledge["potential_locs"].append(room)

func initialise_case():
    # Construct the base tree for what the crewmen know
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
    # Generate correct amount of knowledge (Each thing will be known by a few people)
    var not_guilty_crew = not_solution_crew_list.size()
    for i in range(not_guilty_crew):
        for j in range(Globals.TRAITOR_KNOWLEDGE_COUNT - 1):
            not_solution_crew_list.append(not_solution_crew_list[i])

    var not_solution_rooms = not_solution_rooms_list.size()
    for i in range(not_solution_rooms):
        for j in range(Globals.ROOM_KNOWLEDGE_COUNT - 1):
            not_solution_rooms_list.append(not_solution_rooms_list[i])

    # Pass knowledge around until all is distributed
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

func rule_out_person(crewmember):
    player_knowledge["suspects"].erase(crewmember)

func rule_out_location(room_id):
    player_knowledge["potential_locs"].erase(room_id)

func get_player_knowledge():
    return player_knowledge

func get_suspects():
    return player_knowledge["suspects"]
    
func get_suspect_names():
    var crew_names = get_node("/root/Main/Submarine/CrewmenController").crewmen_names
    var suspect_names = []
    for id in get_suspects():
        suspect_names.append(crew_names[id])
    return suspect_names

func get_potential_locations():
    return player_knowledge["potential_locs"]

func get_potential_location_names():
    var pot_loc_names = []
    for id in get_potential_locations():
        pot_loc_names.append(Globals.ROOM_NAMES[id])
    return pot_loc_names

func is_suspect(crew_id):
    if player_knowledge["suspects"].has(crew_id):
        return true
    return false

func is_potential_location(room_id):
    if player_knowledge["potential_locs"].has(room_id):
        return true
    return false

#-- Dialog system ----------------------------------------------------------------

func chat_button_pressed():
    var crewmen_controller = get_node("/root/Main/Submarine/CrewmenController")
    var player = get_node("/root/Main/Submarine/Player")

    if crewmen_controller.can_interact(player.position):
        advance_dialog(-1)

func advance_dialog(choice):
    var hud = get_node("/root/Main/HUD")

    match dialog_state:
        DialogState.None:
            dialog_state = DialogState.Banter
            hud.show_dialog("Banter!", ["A crewmate", "A room"])
        DialogState.Banter:
            match choice:
                0:
                    dialog_state = DialogState.CrewInterrogation
                    hud.show_dialog("Accuse a person!", ["Alice", "Bob", "Carol"])
                1:
                    dialog_state = DialogState.RoomInterrogation
                    hud.show_dialog("Accuse a room!", ["Kitchen", "Ballroom", "Conservatory"])
        DialogState.CrewInterrogation:
            hud.show_dialog("I do not know this person", ["Ask another question", "As you were"])
        DialogState.RoomInterrogation:
            hud.show_dialog("I do not know this room", ["Ask another question", "As you were"])
