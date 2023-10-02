extends Node2D

export var blue = true

func _ready():
	$States/Positive.visible = false
	$States/Negative.visible = false
	if blue:
		$Sprite.self_modulate = Color.blue
		$AnimationPlayer.play("BlueLight")
	else:
		$Sprite.self_modulate = Color.purple
		$AnimationPlayer.play("PurpleLight")
	pass # Replace with function body.

func _process(delta):
	if (blue):
		if (ParametersGlobal.blueKey):
			$StaticBody2D/CollisionShape2D.disabled = true
		else:
			$StaticBody2D/CollisionShape2D.disabled = false
		$States/Negative.visible = !ParametersGlobal.blueKey
		$States/Positive.visible = ParametersGlobal.blueKey
	else:
		if (ParametersGlobal.purpleKey):
			$StaticBody2D/CollisionShape2D.disabled = true
		else:
			$StaticBody2D/CollisionShape2D.disabled = false
		$States/Negative.visible = !ParametersGlobal.purpleKey
		$States/Positive.visible = ParametersGlobal.purpleKey
			

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		if ((blue and ParametersGlobal.blueKey) or (!blue and ParametersGlobal.purpleKey)):
			$DoorManipulation.play("Open")
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if (body.is_in_group("Player")):
		if ((blue and ParametersGlobal.blueKey) or (!blue and ParametersGlobal.purpleKey)):
			$DoorManipulation.play("Close")
	pass # Replace with function body.
