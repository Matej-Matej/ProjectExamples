extends Node2D

var tilemap: TileMap = null
var pBody

onready var animation = $AnimatedSprite

func _ready():
	tilemap = get_tree().get_nodes_in_group("tilemap")[0]

func _on_Area2D_body_entered(body):
	if (body.is_in_group("player")):
		animation.play("default")
		pBody = body

func rotateWorld(player):
	if (tilemap != null):
		tilemap.rotation_degrees = 90
		player.rotation_degrees = 270

func _on_AnimatedSprite_animation_finished():
	rotateWorld(pBody)
