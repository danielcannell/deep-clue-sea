extends Container

func _ready():
    get_node("AudioStreamPlayer").connect("pressed", self, "loop")

func loop():
    play()