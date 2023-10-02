extends CanvasLayer

onready var level = get_tree().get_nodes_in_group("Level")[0]

onready var title = $Label

var nextLevel

func _init():
	add_to_group("hud")

func _ready():
	title.text = level.title
	$TextureText.visible = false
	$Label2.visible = false
	$AnimationPlayer.play("FadeOut")

func _on_ResetButton_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_zoom_in"):
		_on_TextureRect3_pressed()
		
	if Input.is_action_just_pressed("ui_zoom_out"):
		_on_TextureRect_pressed()
	
	if (Global.music):
		if (!$HBoxContainer/MusicOn.visible):
			$HBoxContainer/MusicOn.visible = true
			$HBoxContainer/MusicOff.visible = false
	else:
		if ($HBoxContainer/MusicOn.visible):
			$HBoxContainer/MusicOn.visible = false
			$HBoxContainer/MusicOff.visible = true

func showText(text):
	$TextTimer.stop()
	$TextAnim.stop()
	text = "        " + text
	$TextureText.visible = true
	$Label2.visible = true
	$Label2.text = text
	$TextAnim.play("textAppear")

func hideText():
	$TextTimer.start(2)

func _on_TextTimer_timeout():
		$TextTimer.stop()
		$TextureText.visible = false
		$Label2.visible = false

func _on_TextureRect_pressed():
	if (level.canMove):
		Global.zoomInCamera(false,-0.1)
	else:
		Global.zoomInCamera(true,-0.1)
	level.assignCamera()

func _on_TextureRect3_pressed():
	if (level.canMove):
		Global.zoomOutCamera(false,0.1)
	else:
		Global.zoomOutCamera(true,0.1)
	level.assignCamera()

func _on_MusicOn_pressed():
	Global.music = false

func _on_MusicOff_pressed():
	Global.music = true
