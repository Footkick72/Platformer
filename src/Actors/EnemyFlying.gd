extends Actor

func _ready():
	set_physics_process(false)

func _on_StompArea_body_entered(body):
	$CollisionShape2D.set_deferred("disabled", true)
	die()

func die():
	$AnimationPlayer.play("Die")

func _on_AreaDetector_area_entered(area):
	rotation = atan2(area.gravity_vec.y, area.gravity_vec.x) - PI/2
	position.y -= 104

func _on_AreaDetector_area_exited(area):
	rotation = atan2(area.gravity_vec.y, area.gravity_vec.x) + PI/2
	position.y += 104
