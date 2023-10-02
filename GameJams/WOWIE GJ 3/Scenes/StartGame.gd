extends Node2D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass

func _process(delta):
	if (Global.music):
		if (!$AudioStreamPlayer2D.playing):	$AudioStreamPlayer2D.play()
	else:
		if ($AudioStreamPlayer2D.playing): $AudioStreamPlayer2D.stop()
	$MouseCursor.global_position = get_global_mouse_position()


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level_1.tscn")
	pass # Replace with function body.
