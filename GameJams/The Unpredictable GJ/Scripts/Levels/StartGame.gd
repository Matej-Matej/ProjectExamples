extends Node2D


func _ready():
	$Timer.start(2)
	pass



func _on_TextureButton_pressed():

	pass # Replace with function body.


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Levels/MainMenuScreen.tscn")
	pass # Replace with function body.
