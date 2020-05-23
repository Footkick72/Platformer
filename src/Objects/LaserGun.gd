extends StaticBody2D


export (PackedScene) var Laser
export var reversed = false
export var fire_speed = 1

func _ready():
	$AnimatedSprite.scale.x = -2 if reversed else 2
	$FirePosition.position.x *= -2 if reversed else 2
	$ShotTimer.wait_time = fire_speed
	$ShotTimer.start()

func fire():
	var laser = Laser.instance()
	laser.speed *= 1 if reversed else -1
	laser.position = $FirePosition.position
	add_child(laser)

func _on_ShotTimer_timeout():
	$AnimationPlayer.play("Fire")
