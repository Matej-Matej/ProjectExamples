extends Node2D

export (Color) var color = Color.white

func _ready():
	$Sprite.self_modulate = color
	$AnimationPlayer.play("Idle")


func _on_Area2D_body_entered(body):
	if (body.is_in_group("playerShapes")):
		$AnimationPlayer.play("Collected")
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Collected"):
		queue_free()
	pass # Replace with function body.
