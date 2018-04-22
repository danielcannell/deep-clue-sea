extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    connect("pressed", self, "play_again")

func play_again():
    get_tree().change_scene("res://Main.tscn")
