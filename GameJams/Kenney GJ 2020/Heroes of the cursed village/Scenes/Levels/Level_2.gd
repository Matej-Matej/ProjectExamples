extends Node2D


func _ready():
	Global.currentLevel = 2
	$CharacterManager/AllCharacters/Character_1.cantGoLeft = true
	pass

func _process(delta):
	if (Global.sound and !$AudioStreamPlayer2D.playing):
		$AudioStreamPlayer2D.play()
	if (!Global.sound):
		$AudioStreamPlayer2D.stop()

func _on_nextLevel_body_entered(body):
	get_tree().change_scene("res://Scenes/Levels/Level_3.tscn")
	pass # Replace with function body.
