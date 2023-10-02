extends Node2D


func _ready():
	Global.currentLevel = 4
	$CharacterManager/AllCharacters/Character_1.cantGoLeft = true
	$CharacterManager/AllCharacters/Character_2.cantSeeInDistance = true
	$CharacterManager/AllCharacters/Character_3.canJump = true
	$CharacterManager/AllCharacters/Character_3.canMoveInAir = true
	pass

func _process(delta):
	if (Global.sound and !$AudioStreamPlayer2D.playing):
		$AudioStreamPlayer2D.play()
	if (!Global.sound):
		$AudioStreamPlayer2D.stop()

func _on_nextLevel_body_entered(body):
	get_tree().change_scene("res://Scenes/Levels/Level_Y.tscn")
	pass # Replace with function body.
