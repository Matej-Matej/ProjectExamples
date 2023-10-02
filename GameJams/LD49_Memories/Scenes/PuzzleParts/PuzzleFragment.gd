extends Node2D

var hud

export (Color, RGB) var fragmentColor = Color("7c3f58")
export var textToShow = ""

func _ready():
	hud = get_tree().get_nodes_in_group("hud")[0]
	$Fragment/puzzle.modulate = fragmentColor
	$Fragment/AnimationPlayer.play("Idle")

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		hud.showText(textToShow)
	
func _on_Area2D_body_exited(body):
	if (body.is_in_group("Player")):
		hud.hideText()
