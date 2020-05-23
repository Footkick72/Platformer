extends Control

var paused = false setget set_paused

func set_paused(value):
	paused = value
	get_tree().paused = value
	$PauseMenu.visible = value

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.paused = not paused #use self.paused to ensure the setter is called
		get_tree().set_input_as_handled()

func _on_HomeButton_button_up():
	self.paused = false
	get_tree().change_scene("res://src/Screens/MainMenu.tscn")

func _on_QuitButton_button_up():
	get_tree().quit()

func _on_RetryButton_button_up():
	get_tree().paused = false
	get_tree().reload_current_scene()
