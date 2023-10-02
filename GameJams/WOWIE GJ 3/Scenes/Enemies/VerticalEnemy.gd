extends Node2D

var up = true
export var speed = 5

func _ready():
	randomize()
	speed = randi() % 6 + 2
	pass

func _process(delta):
	if (up):
		position.y -= speed
	else:
		position.y += speed

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		get_tree().change_scene("res://Scenes/GameOverScreen.tscn")


func _on_ChangeDirection_body_entered(body):
	if (body.is_in_group("Wall")):
		up = !up
	pass # Replace with function body.
