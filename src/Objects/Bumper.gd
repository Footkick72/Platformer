extends Area2D

export var flipped = false

func _ready():
	if flipped:
		rotation = PI

func _on_Bumper_area_entered(area):
	$AnimationPlayer.play("bounce")

func _on_AreaDetector_area_entered(area):
	rotation = atan2(area.gravity_vec.y, area.gravity_vec.x) - PI/2

func _on_AreaDetector_area_exited(area):
	rotation = atan2(area.gravity_vec.y, area.gravity_vec.x) + PI/2
