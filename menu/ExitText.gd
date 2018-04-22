extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    connect("pressed", self, "exit_game")

func exit_game():
    get_tree().quit()
