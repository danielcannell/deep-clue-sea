extends PopupDialog

export (PackedScene) var logentry

func _process(delta):
    if Input.is_action_just_pressed("ui_cancel"):
        self.hide()

func _on_LogWindow_about_to_show():
    var l = logentry.instance()
    l.set_text("Hello world!")
    l.set_strikethrough(true)
    get_node("Split/People").add_child(l)