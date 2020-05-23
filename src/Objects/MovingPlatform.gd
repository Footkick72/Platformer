extends Node2D

export var move_time = 0

func _ready():
#	$AnimationPlayer.set_current_animation("Bobbing")
	$AnimationPlayer.get_animation("Bobbing").set_length(move_time * 2)
	$AnimationPlayer.get_animation("Bobbing").track_set_key_value(0, 0, $StartPos.position)
	$AnimationPlayer.get_animation("Bobbing").track_set_key_value(0, 1, $EndPos.position)
	$AnimationPlayer.get_animation("Bobbing").track_set_key_time(0, 1, move_time)

func _get_configuration_warning():
	return "No move time set" if move_time == 0 else ""
