extends Area2D

func _on_jumpPad_body_entered(body):
	if body.has_method("boost"):
		$AnimatedSprite.play("boost")
		body.boost()

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
