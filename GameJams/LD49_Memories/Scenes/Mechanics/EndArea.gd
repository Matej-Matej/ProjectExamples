extends Node2D

export var next : PackedScene

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		var camera = get_tree().get_nodes_in_group("Camera")[0]
		camera.saveStreamPlayerPosition()
		get_tree().change_scene_to(next)
