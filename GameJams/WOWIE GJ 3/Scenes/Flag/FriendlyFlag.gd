extends Node2D


func _ready():
	randomize()
	$AnimatedSprite.self_modulate = Color(randf(),randf(),randf(),1)
	$AnimatedSprite.play()
	$AnimatedSprite2.play()
	pass


func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		get_tree().change_scene("res://Scenes/GameOverScreen.tscn")
	pass # Replace with function body.
