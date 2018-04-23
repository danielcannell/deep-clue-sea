extends Container

func _ready():
    get_node("Solution").text = Globals.win_text
    get_node("AudioStreamPlayer").connect("finished", self, "loop")

func _on_Button_pressed():
    get_tree().change_scene("res://menu/StartMenu.tscn")

func loop():
    play()