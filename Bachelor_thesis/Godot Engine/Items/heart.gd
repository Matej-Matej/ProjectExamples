extends Area2D

func _ready():
	$AnimationPlayer.play("idle")
	pass


func _on_heart_body_entered(body):
	if (gameState.lifes != gameState.MAX_LIFE):
		get_tree().call_group("gameLevels", "heal" )
		$AnimationPlayer.play("die")
	pass # Replace with function body.



func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass # Replace with function body.
