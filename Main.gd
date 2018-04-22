extends Node

func _on_Submarine_dead():
    get_tree().change_scene("res://GameOver.tscn")