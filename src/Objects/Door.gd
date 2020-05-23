extends StaticBody2D

export var index = 1

func _ready():
	$Button/Sprite.animation = "up" + str(index)
	$TopSprite.animation = "closed" + str(index)
	$BodySprite.animation = "closed" + str(index)

func _on_Button_body_entered(body):
	$Button/Sprite.animation = "pressed" + str(index)
	$CollisionShape2D.set_deferred("disabled", true)
	$TopSprite.animation = "open"
	$BodySprite.animation = "open"
