extends Control

func _ready():
	$AnimationPlayer.play("showOne")
	$TextureButton.visible = false
	$Label2.percent_visible = 0

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level_1.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "showOne"):
		$Timer.start(1.2)
	if (anim_name == "showTwo"):
		$Timer2.start(1)

func _on_Timer_timeout():
	$Timer.stop()
	$AnimationPlayer.play("showTwo")

func _on_Timer2_timeout():
	$Timer2.stop()
	$TextureButton.visible = true
