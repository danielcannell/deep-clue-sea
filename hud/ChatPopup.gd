extends PopupDialog

func _ready():
    pass

func _process(delta):
    if Input.is_action_just_pressed("ui_cancel"):
        self.hide()
