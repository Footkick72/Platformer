extends TextureButton

export (PackedScene) var levelToLoad
export var id = 0

func _ready():
	$VBoxContainer/Title.text = str(id)
	var file = File.new()
	if not file.file_exists("user://level %s.save" % id):
		return
	file.open("user://level %s.save" % id, File.READ)
	$VBoxContainer/HBoxContainer/Stars.text = file.get_line()
	if file.get_line() == "True":
		$VBoxContainer/HBoxContainer/Stars.modulate = Color(1, 1, 0)
	file.close()

func _on_LevelSelectButton_button_up():
	get_tree().change_scene_to(levelToLoad)
