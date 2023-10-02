extends Node2D


func _ready():
	pass

func _process(delta):
	if(ParametersGlobal.purpleKey):
		ParametersGlobal.pKey = true
	if (ParametersGlobal.blueKey):
		ParametersGlobal.bKey = true
	if (ParametersGlobal.radioactiveJumpPad):
		ParametersGlobal.jumpPadKey = true
	if (ParametersGlobal.gravityChanged):
		ParametersGlobal.uKey = true
	if (ParametersGlobal.rotateLevel):
		ParametersGlobal.rotateKey = true
		
	if (ParametersGlobal.pKey):
		$PurpleKey.visible = false
		$PurpleKey/CollisionShape2D.disabled = true
	if (ParametersGlobal.bKey):
		$JumpPadKey.visible = false
		$JumpPadKey/CollisionShape2D.disabled = true
	if (ParametersGlobal.jumpPadKey):
		$BlueKey.visible = false
		$BlueKey/CollisionShape2D.disabled = true
	if (ParametersGlobal.uKey):
		$UpKey.visible = false
		$UpKey/CollisionShape2D.disabled = true
	if (ParametersGlobal.rotateKey):
		$RotateKey.visible = false
		$RotateKey/CollisionShape2D.disabled = true
