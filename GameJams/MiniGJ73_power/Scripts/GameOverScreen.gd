extends Node2D


func _ready():
	pass

func _process(delta):
	$score2.text = "Final score: " + str(get_parent().score + get_parent().coins)
	$wave.text = "Final wave: " + str(get_parent().currentWave)


func _on_TextureButton_pressed():
	get_tree().paused = false
	visible = false
	get_tree().reload_current_scene()
	pass # Replace with function body.
