extends Node2D

func _ready():
    pass

func _on_Crewman_hitpoints_update(hp):
    if hp == 100:
        visible = false
    else:
        visible = true
        get_node("Green").set_scale(Vector2(hp / 100.0, 1))
