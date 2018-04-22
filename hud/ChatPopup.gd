extends PopupDialog

export (PackedScene) var chatbutton

var crewman_text = ""
var prompt_text = ""
var options = []

func _on_ChatWindow_about_to_show():
    var dc = get_node("Container/DetectiveChat")
    for i in range(1, dc.get_child_count()):
        dc.remove_child(dc.get_child(1))
    get_node("Container/CrewmanText").text = crewman_text
    get_node("Container/DetectiveChat/Prompt").text = prompt_text
    for txt in options:
        var cb = chatbutton.instance()
        cb.text = txt
        dc.add_child(cb)
