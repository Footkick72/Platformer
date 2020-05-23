extends Area2D

func _ready():
	$MarginContainer.rect_size = $CollisionShape2D.shape.extents*2
	$MarginContainer/TextureRect.rect_min_size = $CollisionShape2D.shape.extents*2 + Vector2(0,40)
	$MarginContainer.rect_position = -$CollisionShape2D.shape.extents
	var anim_speed = 1/abs(gravity_vec.y)
	$AnimationPlayer.get_animation("Normal").set_length(anim_speed)
	$AnimationPlayer.get_animation("Normal").track_set_key_time(0, 1, anim_speed)

func get_gravity():
	return gravity * gravity_vec.y
