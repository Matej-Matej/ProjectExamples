extends Area2D

export var value = 300
export var scaleY : float = 1

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		body.SPEED = value
		body.scale.y = scaleY
		queue_free()
