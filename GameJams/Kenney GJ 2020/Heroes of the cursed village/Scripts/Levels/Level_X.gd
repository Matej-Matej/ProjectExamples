extends Node2D


func _ready():
	$AnimationPlayer.play("talkingMajor")
	pass


func _on_TextureButton_pressed():
	$AnimationPlayer.play("leave")
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "leave"):
		get_tree().change_scene("res://Scenes/Levels/Level_1.tscn")
	pass # Replace with function body.
