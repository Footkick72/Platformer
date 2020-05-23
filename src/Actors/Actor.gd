extends KinematicBody2D
class_name Actor


export var gravity = 3000.0
var default_gravity = gravity
export var max_speed = Vector2(300, 1000)

var velocity = Vector2.ZERO

func _physics_process(delta):
	if is_on_floor():
		var normal = get_floor_normal()
		$Sprite.rotation = normal.angle()  + PI/2
	else:
		$Sprite.rotation = 0
