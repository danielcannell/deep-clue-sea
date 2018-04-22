extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    connect("pressed", self, "main_menu")

func main_menu():
    get_tree().change_scene("res://menu/StartMenu.tscn")
