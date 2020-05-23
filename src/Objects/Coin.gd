extends Area2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$AnimationPlayer.playback_speed = rng.randf_range(0.5,1.0)

func _on_Coin_body_entered(body):
	$AnimationPlayer.play("fade_out")
