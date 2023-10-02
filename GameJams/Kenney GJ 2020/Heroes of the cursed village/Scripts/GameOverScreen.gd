extends Node2D


func _ready():
	$AnimationPlayer.play("falling")
	pass

func _on_TextureButton_pressed():
	if (Global.currentLevel == 1):
		get_tree().change_scene("res://Scenes/Levels/Level_1.tscn")
	elif (Global.currentLevel == 2):
		get_tree().change_scene("res://Scenes/Levels/Level_2.tscn")
	elif (Global.currentLevel == 3):
		get_tree().change_scene("res://Scenes/Levels/Level_3.tscn")
	elif (Global.currentLevel == 4):
		get_tree().change_scene("res://Scenes/Levels/Level_4.tscn")
	pass # Replace with function body.
