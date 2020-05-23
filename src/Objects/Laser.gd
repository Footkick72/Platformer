extends Area2D

export var speed = 2500

func _physics_process(delta):
	self.position.x += speed * delta

func _on_Laser_area_entered(area):
	queue_free()

func _on_Timer_timeout():
	queue_free()
