extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

func fire():
    return 0.0
    
func flooding():
    return 0.0

func centre_position():
    var extents = get_node("ladder/CollisionShape2D").shape.extents
    return position + extents.y - 4

func contains(pos):
    var epsilon = 5
    var extents = get_node("ladder/CollisionShape2D").shape.extents

    return (
        pos.x + epsilon >= position.x - extents.x and
        pos.x - epsilon <= position.x + extents.x and
        pos.y + epsilon >= position.y - extents.y and
        pos.y - epsilon <= position.y + extents.y)