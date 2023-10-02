extends Node2D

var changingCharacter = 1
var characterPosition = Vector2()

func _ready():
	$ChangeCharacter.visible = false
	pass

func _process(delta):
	if (Input.is_action_pressed("ui_change_character")):
		Engine.time_scale = 0
		
		if (!$ChangeCharacter.visible):
			$ChangeCharacter.visible = true
			$ChangeCharacter.position = get_local_mouse_position()

	else:
		Engine.time_scale = 1
		$ChangeCharacter.visible = false

	if (Input.is_action_just_released("ui_change_character")):
		$AllCharacters/Character_1.currentCharacter = false
		$AllCharacters/Character_2.currentCharacter = false
		$AllCharacters/Character_3.currentCharacter = false
		
		if (changingCharacter == 1):
			$AllCharacters/Character_1.currentCharacter = true
			$AllCharacters/Character_1.position = characterPosition
		if (changingCharacter == 2):
			$AllCharacters/Character_2.currentCharacter = true
			$AllCharacters/Character_2.position = characterPosition
		if (changingCharacter == 3):
			$AllCharacters/Character_3.currentCharacter = true
			$AllCharacters/Character_3.position = characterPosition
	
	$AllCharacters/Camera2D.position = characterPosition

func _on_Character_1_mouse_entered():
	$ChangeCharacter/char1.visible = true
	$ChangeCharacter/char2.visible = false
	$ChangeCharacter/char3.visible = false
	changingCharacter = 1
	pass # Replace with function body.

func _on_Character_2_mouse_entered():
	$ChangeCharacter/char1.visible = false
	$ChangeCharacter/char2.visible = true
	$ChangeCharacter/char3.visible = false
	changingCharacter = 2
	pass # Replace with function body.

func _on_Character_3_mouse_entered():
	$ChangeCharacter/char1.visible = false
	$ChangeCharacter/char2.visible = false
	$ChangeCharacter/char3.visible = true
	changingCharacter = 3
	pass # Replace with function body.
