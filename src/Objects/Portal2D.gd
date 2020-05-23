tool extends Area2D

export (PackedScene) var next_scene

func _get_configuration_warning():
	return "No next scene set" if not next_scene else ""

func teleport():
	get_parent().save_level_data()
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene_to(next_scene)

func _on_Portal2D_body_entered(body):
	teleport()
