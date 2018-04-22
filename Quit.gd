extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    connect("pressed", self, "exit_game")

func exit_game():
    get_tree().quit()
