extends PopupDialog

export (PackedScene) var chatbutton

var crewman_text = ""
var prompt_text = ""
var options = []

signal option_selected

func option_pressed(button):
    var dc = get_node("Container/DetectiveChat")
    for i in range(1, dc.get_child_count()):
        if button == dc.get_child(i):
            print("Selected! " + str(i-1))
            emit_signal("option_selected", i - 1)

func _on_ChatWindow_about_to_show():
    var dc = get_node("Container/DetectiveChat")
    for i in range(1, dc.get_child_count()):
        dc.remove_child(dc.get_child(1))
    get_node("Container/CrewmanText").text = crewman_text
    get_node("Container/DetectiveChat/Prompt").text = prompt_text
    for txt in options:
        var cb = chatbutton.instance()
        cb.text = txt
        cb.connect("pressed", self, "option_pressed", [cb])
        dc.add_child(cb)