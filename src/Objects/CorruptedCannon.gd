extends Area2D


export (PackedScene) var projectile
export var shot_dir = Vector2(0, 0)
export var shot_speed = 600
export var interval = 5
var active = true setget set_active

func set_active(v):
	active = v
	if not active:
		$ShotTimer.stop()
	else:
		$ShotTimer.start()

func _ready():
	if interval != 0:
		$ShotTimer.wait_time = interval
		$ShotTimer.start()

func fire():
	var shot = projectile.instance();
	get_tree().current_scene.add_child(shot)
	shot.global_position = global_position
	shot.velocity = shot_dir * shot_speed

func _on_ShotTimer_timeout():
	$AnimationPlayer.play("Fire")
