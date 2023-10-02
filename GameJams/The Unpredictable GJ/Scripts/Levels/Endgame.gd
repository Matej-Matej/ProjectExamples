extends Node2D

var pp = 0

func _ready():
	$AnimationPlayer.play("End")
	$Label4.visible = false
	pass

func _process(delta):
	var font = $Label3.get_font("font","")
	font.size += 1
	if (font.size >= 70):
		set_process(false)
	$Label3.add_font_override("font",font)	


func _on_TextureButton_pressed():
	get_tree().quit()
	pass # Replace with function body.
