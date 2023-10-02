extends Node2D

var falling = false
var speed = 1

func _ready():
	randomize()
	if (randi()%100 <= 50):
		$AnimatedSprite.visible = true
		$AnimatedSprite2.visible = false
	else:
		$AnimatedSprite2.visible = true
		$AnimatedSprite.visible = false
	add_to_group("FlagChild")
	pass

func _process(delta):
	if (falling):
		position.y += speed


func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		get_tree().change_scene("res://Scenes/GameOverScreen.tscn")
	pass # Replace with function body.
