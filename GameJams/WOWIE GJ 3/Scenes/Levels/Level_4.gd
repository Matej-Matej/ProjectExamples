extends Node2D

var flagChild = preload("res://Scenes/Flag/FlagChild.tscn")
var spawnEnemyTimer = 3
var timeToShowCharacter = 0.1
var timeToNextText = 1.5

var text = [
	"Hi, I am Jimmy's older brother - Timmy.",
	"Jimmy is not feeling good right now. I don't know what happened between you two, but I can help you.",
	"I will use my friends.",
	"Just catch them and you will complete this game. It is that simple!",
	"My brother Jimmy talks about you everyday! He really likes you.",
	"He was so happy when you told him, that you trust him.",
	"He was so excited. But then you refuse to complete the game.",
	"He asked me: What if I am a bad flag. What if he hates me?",
	"I told him, that you like him too. But I was lying to him.",
	"You don't care about us. All you want to do is destroy our world. Our rules. Destroy us.",
	"Do you know what will happen when you catch Jimmy? He will become star, just like me.",
	"He wants to become a star. He really likes watching sky. ",
	"What? You want to find him and finish the game?",
	"Then go, don't waste more time!",
	"Maybe it's not too late.",
	"15"
	]
var actualTextNumber = -1

func _ready():
	Global.level = 4
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	startTweenWithText(text[getActualNumber()])	
	$SpawnEnemy.start(spawnEnemyTimer)
	
func _process(delta):
	if (Global.music):
		if (!$AudioStreamPlayer2D.playing):	$AudioStreamPlayer2D.play()
	else:
		if ($AudioStreamPlayer2D.playing): $AudioStreamPlayer2D.stop()
	$MouseCursor.global_position = get_global_mouse_position()
#	if (Input.is_action_just_pressed("ui_skip")):
##		SKIP TEXT
#		if ($ButtonControl/RichTextLabel.percent_visible != 1):
#			$Tween.stop($ButtonControl/RichTextLabel)
#			$ButtonControl/RichTextLabel.percent_visible = 1
	
	if ($ButtonControl/RichTextLabel.percent_visible == 1):
#		SKIP TO NEXT TEXT
		if (actualTextNumber >= 0):
			if ($ButtonControl/RichTextLabel.percent_visible == 1):
				if ($Timer.is_stopped()):
					$Timer.start(timeToNextText)
		$Tween.playback_speed = Global.tweenSpeed

func _on_killFlagArea_area_entered(area):
	if (area.get_parent().is_in_group("FlagChild")):
		area.get_parent().queue_free()

func _on_SpawnEnemy_timeout():
	randomize()
	var newEnemy = flagChild.instance()
	newEnemy.global_position = $Positions.get_child(randi()%($Positions.get_child_count()-1)+1).global_position
	newEnemy.falling = true
	$FlagChildren.add_child(newEnemy)
	pass # Replace with function body.

func getActualNumber():
	actualTextNumber += 1
	if (actualTextNumber < text.size()):
		return actualTextNumber
	return text.size()-1
	
func startTweenWithText(text):
	$ButtonControl/RichTextLabel.bbcode_text = "[center]" + text + "[/center]"
	$Tween.interpolate_property($ButtonControl/RichTextLabel, "percent_visible",0, 1,timeToShowCharacter*text.length(),Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	makeAction()
	
func makeAction():
	if (actualTextNumber == 0):
		$Label.visible = true
	if (actualTextNumber == 1):
		$Label.visible = false
	pass
	if (actualTextNumber == 15):
		get_tree().change_scene("res://Scenes/Levels/Level_5.tscn")

func _on_Timer_timeout():
	$Timer.stop()
	$ButtonControl/RichTextLabel.percent_visible = 0
	startTweenWithText(text[getActualNumber()])
