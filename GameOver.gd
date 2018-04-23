extends Container

func _ready():
    get_node("AudioStreamPlayer").connect("finished", self, "loop")

func loop():
    play()