extends Area2D


func _ready():
	pass


func _on_DeathArea_body_entered(body):
	print(body.name)
	get_tree().change_scene("res://Scenes/GameOverScreen.tscn")
	pass # Replace with function body.
