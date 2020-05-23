extends Area2D

export var flipped = false

func _ready():
	if flipped:
		scale.y = -1
		position.y += 18
