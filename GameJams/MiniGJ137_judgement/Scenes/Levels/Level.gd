extends Node2D

func _process(delta):
	restartGame()

func restartGame():
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().reload_current_scene()
