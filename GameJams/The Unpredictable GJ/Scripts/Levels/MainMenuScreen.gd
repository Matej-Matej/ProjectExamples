extends Node2D

func _ready():
	pass # Replace with function body.


func _on_TextureButton_pressed():
	$VideoPlayer.stop()
	$VideoPlayer.queue_free()
	get_tree().change_scene("res://Scenes/Levels/Prolog.tscn")
	pass # Replace with function body.


func _on_VideoPlayer_finished():
	$VideoPlayer.stop()
	$VideoPlayer.queue_free()
	get_tree().change_scene("res://Scenes/Levels/Prolog.tscn")
	pass # Replace with function body.
