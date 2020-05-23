extends Actor

var landed = false

func _ready():
	pass
#	velocity.x = - max_speed.x
#	set_physics_process(false)

func _physics_process(delta):
	if (is_on_floor() and not landed):
		landed = true;
		velocity.x = - max_speed.x * sign(-velocity.x + 0.01)
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	velocity.y = clamp(velocity.y, -max_speed.y, max_speed.y)

func _on_StompArea_body_entered(body):
	if (body.global_position.y < $StompArea.global_position.y and sign(gravity) == 1) or (body.global_position.y > $StompArea.global_position.y and sign(gravity) == -1):
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimationPlayer.play("Die")

func die():
	queue_free()

func stop_physics():
	set_physics_process(false)
	$StompArea/CollisionShape2D.disabled = true

func _on_AreaDetector_area_entered(area):
	gravity *= area.get_gravity()
	rotation = atan2(area.gravity_vec.y, area.gravity_vec.x) - PI/2
	position.y -= 93

func _on_AreaDetector_area_exited(area):
	gravity = default_gravity
	rotation = atan2(area.gravity_vec.y, area.gravity_vec.x) + PI/2
	position.y += 93
