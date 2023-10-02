extends Node2D

var flagChild = preload("res://Scenes/Flag/FlagChild.tscn")
var spawnEnemyTimer = 1.2

export var showWin = false

func _ready():
	$Player/Camera2D/Win_Screen.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Global.level = 5
	pass

func _process(delta):
	if (Global.music):
		if (!$AudioStreamPlayer2D.playing):	
			print("play")
			$AudioStreamPlayer2D.play()
	else:
		if ($AudioStreamPlayer2D.playing): $AudioStreamPlayer2D.stop()
	if (showWin): $Player/Camera2D/Win_Screen.visible = true
	$MouseCursor.global_position = get_global_mouse_position()

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		body.canMove = false
		$Flag/AnimationPlayer.play("bye")
	pass # Replace with function body.


func _on_TextureButton_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_TextureButton2_pressed():
	get_tree().change_scene("res://Scenes/StartGame.tscn")
	pass # Replace with function body.
