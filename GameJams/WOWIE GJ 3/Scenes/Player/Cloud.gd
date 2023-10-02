extends Node2D

export var text = ""
export (Texture) var textu = null
export var isCloud = true

func _ready():
	if (textu != null):
		$Sprite.texture_normal = textu
	$RichTextLabel.bbcode_text = "[center]" + text + "[/center]"
	$RichTextLabel.visible = false
	if (!isCloud):
		$RichTextLabel.rect_position = Vector2(-64,140)
	pass
	




func _on_Sprite_button_down():
	$RichTextLabel.visible = true
	pass # Replace with function body.


func _on_Sprite_button_up():
	$RichTextLabel.visible = false
	pass # Replace with function body.
