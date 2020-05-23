extends Actor

export var bounce_height = 1600
export var bumper_height = 2000
var consecutive_jumps = 0
var coins = 0
var pounding = false
var is_dead = false
var invincible = false
signal died

func _ready():
	$CanvasLayer/Light2D.scale = get_viewport_rect().size/$CanvasLayer/Light2D.texture.get_size()
	$CanvasLayer/Light2D.position.y = get_viewport_rect().size.y/2

func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("move_right"):
		direction += 1
		$TrailParticles.scale.x = -1
		$TrailParticles.emitting = true
	if Input.is_action_pressed("move_left"):
		direction -= 1
		$TrailParticles.scale.x = 1
		$TrailParticles.emitting = true
	if Input.is_action_just_pressed("jump"):
		if (is_on_floor() and sign(gravity) == 1)  or (is_on_ceiling() and sign(gravity) == -1):
			velocity.y = -max_speed.y * sign(gravity)
		elif (is_on_wall()):
			if sign(consecutive_jumps) != sign(direction) or consecutive_jumps == 0:
				velocity.y = -max_speed.y * sign(gravity)
				consecutive_jumps = sign(direction) * 1
	if Input.is_action_just_pressed("ground_pound"):
		if not is_on_floor():
			pounding = not pounding
	if pounding:
		velocity.y = 2*max_speed.y*sign(gravity)
		if (is_on_floor() and sign(gravity) == 1)  or (is_on_ceiling() and sign(gravity) == -1):
			$StompParticles.emitting = true
			pounding = false
	if (is_on_floor() and sign(gravity) == 1) or (is_on_ceiling() and sign(gravity) == -1):
		consecutive_jumps = 0
		$TrailParticles.emitting = true
	else:
		$TrailParticles.emitting = false 
	if (not Input.is_action_pressed("move_left")) and (not Input.is_action_pressed("move_right")):
		$TrailParticles.emitting = false
	velocity.x = max_speed.x * direction
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if (velocity.y > max_speed.y and sign(gravity) == 1):
		velocity.y = max_speed.y
	if  (velocity.y < -max_speed.y and sign(gravity) == -1):
		velocity.y = -max_speed.y

func _on_EnemyDetector_area_entered(area):
	velocity.y = -bounce_height * sign(gravity)
	consecutive_jumps = 0

func _on_EnemyDetector_body_entered(body):
	if invincible:
		return
	if not is_dead:
		is_dead = true
		$AnimationPlayer.play("Die")

func die():
	queue_free()
	get_tree().reload_current_scene()

func _on_VisibilityNotifier2D_screen_exited():
	if invincible:
		return
	if not is_dead:
		is_dead = true
		$AnimationPlayer.play("Die")

func _on_BumperDetector_area_entered(area):
	velocity.y = -bumper_height * sign(gravity)
	consecutive_jumps = 0

func _on_CameraBottomLimit_area_exited(area):
	$Camera2D.limit_bottom = $CameraBottomLimit/CollisionShape2D.global_position.y

func _on_CameraBottomLimit_area_entered(area):
	$Camera2D.limit_bottom = 100000000

func _on_LaserDetector_area_entered(area):
	if invincible:
		return
	if not is_dead:
		is_dead = true
		$AnimationPlayer.play("Die")

func _on_CoinDetector_area_entered(area):
	coins += 1

func _on_AreaDetector_area_entered(area):
	gravity *= area.get_gravity()
	rotation = atan2(area.gravity_vec.y, area.gravity_vec.x) - PI/2
	$CameraBottomLimit.rotation_degrees = 180
	$CameraBottomLimit.position.y -= 96*2
	$TrailParticles.scale.y = -1
	position.y -= 96

func _on_AreaDetector_area_exited(area):
	gravity = default_gravity
	rotation = atan2(area.gravity_vec.y, area.gravity_vec.x) + PI/2
	$CameraBottomLimit.rotation_degrees = 0
	$CameraBottomLimit.position.y += 96*2
	$TrailParticles.scale.y = 1
	position.y += 96

func _on_SpikeDetector_area_entered(area):
	if invincible:
		return
	if not is_dead:
		is_dead = true
		$AnimationPlayer.play("Die")

func _on_PoisionDetector_area_entered(area):
	if invincible:
		return
	if not is_dead:
		$AnimationPlayer.play("DiePoison")

func _on_PoisionDetector_area_exited(area):
	if invincible:
		return
	if not is_dead:
		$AnimationPlayer.play_backwards("DiePoison")

func _on_SpikeDetector_body_entered(body):
	if invincible:
		return
	if not is_dead:
		is_dead = true
		$AnimationPlayer.play("Die")
