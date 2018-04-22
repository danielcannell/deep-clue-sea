extends CanvasLayer

func _on_Submarine_hitpoints_update(hp):
    get_node("Healthbar/Green").set_scale(Vector2(hp / 100.0, 1))