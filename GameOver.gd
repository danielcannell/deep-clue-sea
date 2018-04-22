extends Container

func _ready():
    connect("pressed", self, "loop")

func loop():
    play()