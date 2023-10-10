extends Area2D

var taken = false

func _on_star_body_entered(body):
	if not taken:
		if (gameState.soundEffect) : $pickSFX.play()
		gameState.isStateUpdated = true
		get_tree().call_group("gameLevels", "pickStar")
		taken = true
		$AnimationPlayer.play("die")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()
