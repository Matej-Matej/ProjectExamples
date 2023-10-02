extends Node2D


func _ready():
	pass


func _on_JumpPadArea_body_entered(body):
	if (body.is_in_group("playerShapes")):
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
		$AnimatedSprite.play()
		body.boost()
