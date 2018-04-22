extends CanvasLayer

func _on_Submarine_hitpoints_update(hp):
    get_node("Healthbar/Green").set_scale(Vector2(hp / 100.0, 1))

func _on_LogButton_pressed():
    get_node("LogWindow").popup()

func _on_ChatButton_pressed():
    show_dialog("Yes captain?", ["Ask about a person", "Ask about a place", "Nevermind"])

func show_dialog(text, list_of_choices):
    var cw = get_node("ChatWindow")
    cw.crewman_text = text
    cw.prompt_text = "Ask about..."
    cw.options = list_of_choices
    cw.popup()