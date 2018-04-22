extends Container

func _ready():
    get_node("Solution").text = Globals.win_text
    connect("finished", self, "loop")

func _on_Button_pressed():
    get_tree().change_scene("res://Main.tscn")

func loop():
    play()