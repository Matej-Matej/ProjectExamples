extends Popup

export (String, FILE, "*.tscn") var back

func _ready():
	$soundCheckButton.pressed = gameState.soundEffect
	$musicCheckButton.pressed = gameState.musicEffect
	$fullscreenCheckButton.pressed = gameState.fullScreen
	pass

func _on_backButton_pressed():
	visible = false
	gameState.saveGameState()
	pass # Replace with function body.

func _on_soundCheckButton_toggled(button_pressed):
	gameState.soundEffect = button_pressed
	pass # Replace with function body.


func _on_musicCheckButton_toggled(button_pressed):
	gameState.musicEffect = button_pressed
	gameState.isStateUpdated = true
	pass # Replace with function body.


func _on_fullscreenCheckButton_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	gameState.fullScreen = button_pressed
	pass # Replace with function body.
