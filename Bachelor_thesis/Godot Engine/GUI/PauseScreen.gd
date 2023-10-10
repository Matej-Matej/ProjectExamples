extends Popup

func _ready():
	pass
	
func _process(delta):
	if ($OptionScreen.visible or $InstructionScreen.visible):
		$Buttons.visible = false
		$pauseBackground.visible = false
		$pauseLabel.visible = false
	else:
		$Buttons.visible = true
		$pauseBackground.visible = true
		$pauseLabel.visible = true

func _on_continuePlayingButton_pressed():
	visible = false
	pass # Replace with function body.

func _on_optionButton_pressed():
	$OptionScreen.visible = true
	pass # Replace with function body.

func _on_instructionScreenButton_pressed():
	$InstructionScreen.visible = true
	pass # Replace with function body.


func _on_exitGameButton_pressed():
	gameState.saveGameState()
	get_tree().quit()
	pass # Replace with function body.
