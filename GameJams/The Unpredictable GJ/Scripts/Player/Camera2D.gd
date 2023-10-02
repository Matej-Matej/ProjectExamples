extends Camera2D


func _ready():
	$AnimationPlayer.play("GoDown")
	pass

func _process(delta):
	$Gui/Keys/BlueKeys.visible = ParametersGlobal.blueKey
	$Gui/Keys/RedKeys.visible = ParametersGlobal.purpleKey
	
	if ParametersGlobal.p1:
		$Gui/Parts/p1.self_modulate = Color.white
	else:
		$Gui/Parts/p1.self_modulate = Color.black
	if ParametersGlobal.p2:
		$Gui/Parts/p2.self_modulate = Color.white
	else:
		$Gui/Parts/p2.self_modulate = Color.black
	if ParametersGlobal.p3:
		$Gui/Parts/p3.self_modulate = Color.white
	else:
		$Gui/Parts/p3.self_modulate = Color.black
	if ParametersGlobal.p4:
		$Gui/Parts/p4.self_modulate = Color.white
	else:
		$Gui/Parts/p4.self_modulate = Color.black
	if ParametersGlobal.p5:
		$Gui/Parts/p5.self_modulate = Color.white
	else:
		$Gui/Parts/p5.self_modulate = Color.black
	if ParametersGlobal.p6:
		$Gui/Parts/p6.self_modulate = Color.white
	else:
		$Gui/Parts/p6.self_modulate = Color.black

func _on_CheckButton_toggled(button_pressed):
	if (button_pressed):
		$AnimationPlayer.play("GoUp")
	else:
		$AnimationPlayer.play("GoDown")
	
	pass # Replace with function body.
