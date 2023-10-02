extends Node2D

func _ready():
	$AnimatedSprite.play("default")


func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		if (ParametersGlobal.radioactiveJumpPad):
			body.boost()
		else:
			body._on_TextureButton_pressed()
			body.setText("You did not make it this time.")
	pass # Replace with function body.
