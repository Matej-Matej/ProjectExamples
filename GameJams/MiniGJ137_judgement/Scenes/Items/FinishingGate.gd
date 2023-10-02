extends Node2D

export var next : PackedScene

func _on_Area2D_body_entered(body):
	if (body.is_in_group("player")):
		endLevel()
	
func endLevel():
	get_tree().change_scene_to(next)
