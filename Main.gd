extends Node

func win():
    get_tree().change_scene("res://WinScreen.tscn")
    Globals.win_text = "You did it!"

func _on_Submarine_dead():
    get_tree().change_scene("res://GameOver.tscn")