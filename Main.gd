extends Node

func _on_Submarine_dead():
    get_tree().change_scene("res://GameOver.tscn")


func _on_DetectiveRoot_case_closed(win_text):
    Globals.win_text = win_text
    get_tree().change_scene("res://WinScreen.tscn")
