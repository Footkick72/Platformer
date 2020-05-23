extends StaticBody2D


func _ready():
	$NinePatchRect.rect_size = Vector2($CollisionShape2D.shape.extents.y, $CollisionShape2D.shape.extents.x)/($NinePatchRect.rect_scale/2)
