extends Node2D

var redCard = preload("res://Assets/ShipInside/KeysRed.png")
var blueCard = preload("res://Assets/ShipInside/KeysBlue.png")

export var blue = true

func _ready():
	if (blue):
		$Node2D/Sprite.texture = blueCard
	else:
		$Node2D/Sprite.texture = redCard
#	$Node2D/AnimationPlayer.play("Idle")
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	print(body)
	if (body.is_in_group("Player")):
		if (blue):
			ParametersGlobal.blueKey = true
			body.setText("You can now open blue Door.")
		if (!blue):
			ParametersGlobal.purpleKey = true
			body.setText("You can now open purple Door.")
	queue_free()
	pass # Replace with function body.
