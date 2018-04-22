extends PopupDialog

export (PackedScene) var chatbutton

var crewman_text = ""
var prompt_text = ""
var options = []

signal option_selected

func option_pressed(button):
    var dc = get_node("Container/DetectiveChat")
    var selected = -1
    for i in range(1, dc.get_child_count()):
        if button == dc.get_child(i):
            selected = i-1
            break
    if selected >= 0:
        emit_signal("option_selected", selected)

func _on_ChatWindow_about_to_show():
    var dc = get_node("Container/DetectiveChat")
    for i in range(1, dc.get_child_count()):
        dc.get_child(1).disconnect("pressed", self, "option_pressed")
        dc.remove_child(dc.get_child(1))
    get_node("Container/CrewmanText").text = crewman_text
    get_node("Container/DetectiveChat/Prompt").text = prompt_text
    for txt in options:
        var cb = chatbutton.instance()
        cb.text = txt
        cb.connect("pressed", self, "option_pressed", [cb])
        dc.add_child(cb)