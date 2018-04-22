extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    connect("pressed", self, "start_game")

func start_game():
    get_tree().change_scene("res://Main.tscn")