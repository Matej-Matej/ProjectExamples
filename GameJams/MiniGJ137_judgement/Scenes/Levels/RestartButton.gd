extends TextureButton


func _ready():
	pass


func _on_RestartButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/MainMenu.tscn")

