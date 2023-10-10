extends Popup

func _on_restartButton_pressed():
	gameState.restartGame()
	get_tree().change_scene("res://Screens/Levels/Level_1.tscn")

func _on_continueButton_pressed():
	gameState.runLastLevel()
	pass # Replace with function body.
