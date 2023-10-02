extends Node2D


func _ready():
	pass


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level_X.tscn")
	pass # Replace with function body.


func _on_TextureButton2_pressed():
	get_tree().quit()
	pass # Replace with function body.
