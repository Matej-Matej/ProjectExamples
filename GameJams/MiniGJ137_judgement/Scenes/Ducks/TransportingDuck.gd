extends Node2D

onready var transportingCage = $TransportingCage
onready var animation = $AnimatedSprite

func _ready():
	animation.play("default")

func _on_Area2D_body_entered(body):
	if (body.is_in_group("player")):
		transportPlayer(body)

func transportPlayer(player):
	player.global_position = transportingCage.global_position
