extends Node2D

func _ready():
    pass

func _on_Crewman_hitpoints_update(hp):
    if hp == Globals.CREW_MAX_HITPOINTS:
        visible = false
    else:
        visible = true
        get_node("Green").set_scale(Vector2(hp / float(Globals.CREW_MAX_HITPOINTS), 1))
