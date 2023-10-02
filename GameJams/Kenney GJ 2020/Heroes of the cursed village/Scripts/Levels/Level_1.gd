extends Node2D


func _ready():
	Global.currentLevel = 1
	$CharacterManager/AllCharacters/Character_1.canJump = false
	$CharacterManager/AllCharacters/Character_2.canJump = false
	$CharacterManager/AllCharacters/Character_3.canJump = true
	$CharacterManager/AllCharacters/Character_1.infiniteJumping = false
	$CharacterManager/AllCharacters/Character_2.infiniteJumping = true
	$CharacterManager/AllCharacters/Character_3.infiniteJumping = false
	$CharacterManager/AllCharacters/Character_1.eyeDisability = false
	$CharacterManager/AllCharacters/Character_2.eyeDisability = false
	$CharacterManager/AllCharacters/Character_3.eyeDisability = true
	$CharacterManager/AllCharacters/Character_1.canMoveInAir = false
	$CharacterManager/AllCharacters/Character_2.canMoveInAir = false
	$CharacterManager/AllCharacters/Character_3.canMoveInAir = false
	$CharacterManager/AllCharacters/Character_1.cantGoLeft = false
	$CharacterManager/AllCharacters/Character_2.cantGoLeft = false
	$CharacterManager/AllCharacters/Character_3.cantGoLeft = false
	$CharacterManager/AllCharacters/Character_1.cantSeeInDistance = false
	$CharacterManager/AllCharacters/Character_2.cantSeeInDistance = false
	$CharacterManager/AllCharacters/Character_3.cantSeeInDistance = false
	$AnimationPlayer.play("curseNPC")
	pass

func _process(delta):
	if (Global.sound and !$AudioStreamPlayer2D.playing):
		$AudioStreamPlayer2D.play()
	if (!Global.sound):
		$AudioStreamPlayer2D.stop()

func _on_nextLevel_body_entered(body):
	get_tree().change_scene("res://Scenes/Levels/Level_2.tscn")
	pass # Replace with function body.


func _on_DeathArea_body_entered(body):
	$CharacterManager/AllCharacters/Camera2D/GameOverScreen.visible = true
	pass # Replace with function body.
