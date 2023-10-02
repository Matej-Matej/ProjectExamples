extends Node2D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$RichTextLabel2.visible = false
	pass

func _process(delta):
	if (Global.music):
		if (!$AudioStreamPlayer2D.playing):	$AudioStreamPlayer2D.play()
	else:
		if ($AudioStreamPlayer2D.playing): $AudioStreamPlayer2D.stop()
	$MouseCursor.global_position = get_global_mouse_position()
	if (Global.level == 2):
		$Cloud.visible = false
		$Friends.visible = false
	elif (Global.level == 4):
		$Cloud.visible = true
		$Friends.visible = false
	elif (Global.level == 5):
		$Friends.visible = true
		

func _on_TextureButton_pressed():
	if (Global.level == 2):
		get_tree().change_scene("res://Scenes/Levels/Level_2.tscn")
	elif (Global.level == 4):
		get_tree().change_scene("res://Scenes/Levels/Level_4.tscn")
	elif (Global.level == 5):
		get_tree().change_scene("res://Scenes/Levels/Level_5.tscn")
	else:
		get_tree().change_scene("res://Scenes/Levels/Level_2.tscn")
	pass # Replace with function body.


func _on_TextureButton2_button_down():
	$RichTextLabel2.visible = true
	pass # Replace with function body.


func _on_TextureButton2_button_up():
	$RichTextLabel2.visible = false
	pass # Replace with function body.
