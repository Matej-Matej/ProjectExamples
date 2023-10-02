extends Area2D


func _ready():
	pass


func _on_GameOverArea_body_entered(body):
	if (body.is_in_group("playerShapes")):
		SaveGlobal.loadGame()
