extends Node2D

onready var staticBody = $StaticBody2D
onready var sprite = $Sprite

func _init():
	add_to_group("opening")

func open():
	staticBody.queue_free()
	sprite.queue_free()
