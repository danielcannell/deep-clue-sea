extends PopupDialog

export (PackedScene) var logentry

func _process(delta):
    if Input.is_action_just_pressed("ui_cancel"):
        self.hide()

func clear_names_and_places():
    var l = get_node("Split/People")
    for i in range(1, l.get_child_count()):
        l.remove_child(l.get_child(1))
    l = get_node("Split/Places")
    for i in range(1, l.get_child_count()):
        l.remove_child(l.get_child(1))

func add_name(name, strike):
    var l = logentry.instance()
    l.set_text(name)
    l.set_strikethrough(strike)
    get_node("Split/People").add_child(l)

func add_place(name, strike):
    var l = logentry.instance()
    l.set_text(name)
    l.set_strikethrough(strike)
    get_node("Split/Places").add_child(l)

func _on_LogWindow_about_to_show():
    var d_root = get_node("/root/Main/DetectiveRoot")
    var crew_name_list = get_node("/root/Main/Submarine/CrewmenController").crewman_names
    clear_names_and_places()
    for i in range(8):
        add_name("Crewman " + crew_name_list[i], !d_root.is_suspect(i))
    for i in range(8):
        add_place(Globals.ROOM_NAMES[i], !d_root.is_potential_location(i))