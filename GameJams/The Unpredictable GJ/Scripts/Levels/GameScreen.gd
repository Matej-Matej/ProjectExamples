extends Node2D

func _ready():
	$AllGame/AnimatedSprite4.visible = false
	pass # Replace with function body.

func _process(delta):
	if (ParametersGlobal.rotateLevel):
		$AllGame.rotation_degrees = 90
		$AllGame/Player.rotation_degrees = -90
	else:
		$AllGame.rotation_degrees = 0
		$AllGame/Player.rotation_degrees = 0
	pass

	if (ParametersGlobal.mirrorLevel):
		$AllGame.scale.x = - abs($AllGame.scale.x)
		$AllGame/Player/Camera2D.scale.x = - abs($AllGame/Player/Camera2D.scale.x )
	else:
		$AllGame.scale.x = abs($AllGame.scale.x)
		
	if (ParametersGlobal.mirrorLevel and ParametersGlobal.rotateLevel):
		$AllGame/Player.scale.y = - ( abs($AllGame/Player.scale.y))
		$AllGame/Player/Camera2D.scale.x = abs($AllGame/Player/Camera2D.scale.x )
		
	if (ParametersGlobal.shipGone and !$AllGame/AnimatedSprite4.visible):
		$AllGame/AnimatedSprite4.visible = true
		$AllGame/AnimatedSprite4.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WaterArea_body_entered(body):
	if (!ParametersGlobal.moveInWater and body.is_in_group("Player")):
		body._on_TextureButton_pressed()
		body.setText("You did not make it this time.")
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.setText("You did not make it this time.")
		body._on_TextureButton_pressed()
	pass # Replace with function body.


func _on_Area2D2_body_entered(body):
	if (body.is_in_group("Player")):
		body.setText("This is my bed. Even my toy is here. ")
	pass # Replace with function body.


func _on_Area2D3_body_entered(body):
	if (body.is_in_group("Player")):
		body.setText("I wonder what is this portal for.")
	pass # Replace with function body.


func _on_AnimatedSprite_animation_finished():
	get_tree().change_scene("res://Scenes/Levels/Endgame.tscn")
	pass # Replace with function body.
