extends Node2D

var speed = 2
export var left = true
export var distance = 64
var startDistance = 0

func _ready():
	pass

func _process(delta):
	startDistance += speed
	if (left):
		position.x -= speed
	else:
		position.x += speed
	if (startDistance >= distance):
		left = !left
		startDistance = 0

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		get_tree().change_scene("res://Scenes/GameOverScreen.tscn")
	pass # Replace with function body.
