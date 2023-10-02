extends Node2D

export (Color, RGB) var rectangleColor
export var haveHeart = false

func _ready():
	if (haveHeart):
		$Sprite2.visible = true
		$HeartAnim.play("beat")
	else:
		$Sprite2.visible = false
	$AnimationPlayer.play("idle")
	$Sprite.modulate = rectangleColor
