extends Node2D

var p1 = preload("res://Assets/ShipInside/Parts/1.png")
var p2 = preload("res://Assets/ShipInside/Parts/2.png")
var p3 = preload("res://Assets/ShipInside/Parts/3.png")
var p4 = preload("res://Assets/ShipInside/Parts/4.png")
var p5 = preload("res://Assets/ShipInside/Parts/5.png")
var p6 = preload("res://Assets/ShipInside/Parts/6.png")

enum PART_EFFECT { moveInWater, rotateLevel, canJump, gravityChanged, radioactiveJumpPad, mirrorLevel }
export(PART_EFFECT) var effect

func _ready():
	$Node2D/AnimationPlayer.play("Idle")
	match effect:
		PART_EFFECT.moveInWater:
			$Node2D/Sprite.texture = p1
			pass
		PART_EFFECT.rotateLevel:
			$Node2D/Sprite.texture = p2
			pass
		PART_EFFECT.canJump:
			$Node2D/Sprite.texture = p3
			pass
		PART_EFFECT.gravityChanged:
			$Node2D/Sprite.texture = p4
			pass
		PART_EFFECT.radioactiveJumpPad:
			$Node2D/Sprite.texture = p5
			pass
		PART_EFFECT.mirrorLevel:
			$Node2D/Sprite.texture = p6
			pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		match effect:
			PART_EFFECT.moveInWater:
				ParametersGlobal.moveInWater = true
				ParametersGlobal.p1 = true
				body.setText("Now you can move in radioactive water.")
				pass
			PART_EFFECT.rotateLevel:
				ParametersGlobal.rotateLevel = true
				ParametersGlobal.p2 = true
				body.setText("The level is rotated now.")
				pass
			PART_EFFECT.canJump:
				ParametersGlobal.canJump = true
				ParametersGlobal.p3 = true
				body.setText("You can jump now.")
				pass
			PART_EFFECT.gravityChanged:
				ParametersGlobal.gravityChanged = true
				ParametersGlobal.p4 = true
				body.setText("The gravity changed.")
				pass
			PART_EFFECT.radioactiveJumpPad:
				ParametersGlobal.radioactiveJumpPad = true
				ParametersGlobal.p5 = true
				body.setText("Radioactive on the ground no longer kills you. You can use them as jump pad.")
				pass
			PART_EFFECT.mirrorLevel:
				ParametersGlobal.mirrorLevel = true
				ParametersGlobal.p6 = true
				body.setText("The level is mirrored now.")
				pass
	$Node2D/AnimationPlayer.play("Die")
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Die"):
		queue_free()
	pass # Replace with function body.
