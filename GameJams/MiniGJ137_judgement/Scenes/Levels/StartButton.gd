extends TextureButton


func _ready():
	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
