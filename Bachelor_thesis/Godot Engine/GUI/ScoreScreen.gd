extends Popup

func _ready():
	if (gameState.loadScore() != null):	$score.text = gameState.loadScore()

func _on_backToMenuButton_pressed():
	visible = false
	pass # Replace with function body.
