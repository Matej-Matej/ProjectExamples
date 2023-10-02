extends StaticBody2D

export var timeToBeAlive = 0.8
export var timeToReappear = 2

func _on_Timer_timeout():
	$Timer.stop()
	$CollisionShape2D.disabled = true
	$Sprite.visible = false
	$ReappearTimer.start(timeToReappear)

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		$Timer.start(timeToBeAlive)

func _on_ReappearTimer_timeout():
	$ReappearTimer.stop()
	$CollisionShape2D.disabled = false
	$Sprite.visible = true
