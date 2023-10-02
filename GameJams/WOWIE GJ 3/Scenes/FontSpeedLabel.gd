extends Node2D


func _ready():
	$RichTextLabel.visible = false
	pass

func _process(delta):
	if (Global.speedInc):
		Global.speedInc = false
		$RichTextLabel.visible = true
		$RichTextLabel.bbcode_text = "[center] Text speed: " + str(Global.tweenSpeed) + "[/center]"
		$Timer.start(1.5)
		pass

func _on_Timer_timeout():
	$RichTextLabel.visible = false
	pass # Replace with function body.
