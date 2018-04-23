extends CanvasLayer

signal chat_button_pressed
signal chat_option_selected

func _on_Submarine_hitpoints_update(hp):
    get_node("Healthbar/Green").set_scale(Vector2(hp / float(Globals.SUB_MAX_HITPOINTS), 1))

func _on_LogButton_pressed():
    get_node("LogWindow").popup()

func _on_ChatButton_pressed():
    emit_signal("chat_button_pressed")

func show_dialog(text, list_of_choices):
    var cw = get_node("ChatWindow")
    cw.crewman_text = text
    cw.prompt_text = "Ask about..."
    cw.options = list_of_choices
    cw.popup()

func hide_dialog():
    var cw = get_node("ChatWindow")
    cw.hide()

func _on_ChatWindow_option_selected(id):
    emit_signal("chat_option_selected", id)
