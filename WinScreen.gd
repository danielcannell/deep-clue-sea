extends Container

func _ready():
    get_node("Solution").text = Globals.win_text

func _on_Button_pressed():
    get_tree().change_scene("res://Main.tscn")
