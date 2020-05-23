extends Area2D

export(Array, Texture) var textures
var active = true setget set_active

func set_active(v):
	$Particles2D.emitting = v
	$CollisionShape2D.disabled = !v

func _ready():
	randomize()
	$Particles2D.texture = textures[rand_range(0, 8)]


