extends Node2D


func _ready():
	$AnimationPlayer.play("Move")
	$TextureButton.disabled = true
	pass


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	$TextureButton.disabled = false
	pass # Replace with function body.
