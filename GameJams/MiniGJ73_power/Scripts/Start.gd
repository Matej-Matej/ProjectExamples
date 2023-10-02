extends Node2D


func _ready():
	pass
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_buy") or Input.is_action_just_pressed("PickUp")):
		_on_TextureButton_pressed()


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Tutorial.tscn")
	pass # Replace with function body.
