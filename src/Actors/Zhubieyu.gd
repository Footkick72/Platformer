extends KinematicBody2D

export var speed = 500
var dir = 1
var state = "none"
var landed = false
var health = 3
var lift_count = 0
export (PackedScene) var next_scene

func teleport():
	get_parent().save_level_data()
	$AnimationPlayer.play("fade_out")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene_to(next_scene)

func deactivate_cannons():
	$Sprite/CorruptedCannon.active = false
	$Sprite/CorruptedCannon2.active = false

func activate_cannons():
	$Sprite/CorruptedCannon.active = true
	$Sprite/CorruptedCannon2.active = true

func _physics_process(delta):
	if state == "flying":
		flight_movement(delta)
	if state == "falling":
		move_and_slide(Vector2(0, 5000), Vector2.UP)
		if is_on_floor():
			state = "none"
			dir = 1
			$LandTimer.start()
	if state == "charging":
		state = "none"
		$AnimationPlayer.play("charge")
	if state == "ramming":
		ram_movement(delta)
	if state == "relaxing":
		state = "none"
		$AnimationPlayer.play("rest")
	if state == "resting":
		state = "none"
		$StompArea/CollisionShape2D.disabled = false
		$RestTimer.start()
	if state == "angry":
		state = "none"
		$AnimationPlayer.play("angry")
	if state == "test_health":
		if health == 0:
			state = "none"
			teleport()
		else:
			state = "lifting_off"
			$PoisonBreath.active = true
			$Sprite/CorruptedCannon.active = true
			$Sprite/CorruptedCannon2.active = true
			$FlyTimer.start()
	if state == "lifting_off":
		move_and_slide(Vector2(0, -1000))
		lift_count += 1
		if (lift_count == 25):
			state = "flying"
			lift_count = 0

func begin_ramming():
	state = "ramming"

func flight_movement(delta):
	move_and_slide(Vector2(speed * dir,0), Vector2.UP)
	if is_on_wall():
		dir *= -1

func ram_movement(delta):
	move_and_slide(Vector2(dir * 3000, 0), Vector2.UP)
	if is_on_wall():
		dir *= -1
		state = "relaxing"

func _on_FlyTimer_timeout():
	state = "none"
	$PoisonBreath.active = false
	$Sprite/CorruptedCannon.active = false
	$Sprite/CorruptedCannon2.active = false
	$AnimationPlayer.play("shake")
	yield($AnimationPlayer,"animation_finished")
	state = "falling"

func _on_RestTimer_timeout():
	$StompArea/CollisionShape2D.disabled = true
	state = "charging"

func end_relax():
	state = "resting"
	scale.x *= -1
	$Node2D.scale.x *= -1

func lift_off():
	state = "test_health"

func _on_StompArea_body_entered(body):
	if $StompArea/CollisionShape2D.disabled == true:
		return
	health -= 1
	$Node2D/HealthBar.value = health
	$StompArea/CollisionShape2D.set_deferred("disabled", true)
	$RestTimer.stop()
	state = "angry"
	scale.x = 1
	$Node2D.scale.x = 1

func _on_LandTimer_timeout():
	state = "charging"

func _on_VisibilityNotifier2D_screen_entered():
	state = "flying"
	$FlyTimer.start()
