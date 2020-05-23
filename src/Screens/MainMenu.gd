extends Control


func _on_PlayButton_button_up():
	get_tree().change_scene("res://src/Screens/LevelSelector.tscn")

func _on_QuitButton_button_up():
	get_tree().quit()
