extends Node2D

func _ready():
	pass
	
#	 tlacidla sa skryjú ak je zapnuté okno možností alebo skóre 
func _process(delta):
	setButtons($OptionScreen.visible or $ScoreScreen.visible)
	
func setButtons(disable):
	$Buttons/playGameButton.disabled = disable
	$Buttons/optionButton.disabled = disable
	$Buttons/scoreButton.disabled = disable
	$Buttons/exitGameButton.disabled = disable
	$Buttons.visible = !disable
	$gameLogo.visible = !disable
	$buttonsBackground.visible = !disable
	
func _on_playGameButton_pressed():
	if (gameState.lastLevelName != ""):
		$ContinueGameScreen.visible = true
	else:
		get_tree().change_scene("res://Screens/Levels/Level_1.tscn")
	pass # Replace with function body.


func _on_optionButton_pressed():
	$OptionScreen.visible = true
	pass # Replace with function body.


func _on_exitGameButton_pressed():
	gameState.saveGameState()
	get_tree().quit()
	pass # Replace with function body.


func _on_scoreButton_pressed():
	$ScoreScreen.visible = true
	pass # Replace with function body.
