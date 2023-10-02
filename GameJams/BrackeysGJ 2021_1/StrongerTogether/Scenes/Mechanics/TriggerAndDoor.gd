extends Node2D

var enteringBodyName = ""
export (Color) var color = Color.white

func _ready():
	$Door/Sprite.self_modulate = color
	$Trigger/Sprite.self_modulate = color

func _on_Area2D_body_entered(body):
	if (body.is_in_group("playerShapes")):
		$Trigger/Sprite.frame = 1
		if (enteringBodyName == ""): enteringBodyName = body.name
		manageDoor(true)


func _on_Area2D_body_exited(body):
	if (enteringBodyName == body.name and body.is_in_group("playerShapes")):
		enteringBodyName = ""

func manageDoor(open):
	$Door.visible = !open
	$Door/StaticBody2D.set_collision_layer_bit(1,!open)
	$Door/StaticBody2D.set_collision_mask_bit(0,!open)
