extends Node2D

var timeToShowCharacter = 0.1
var timeToNextText = 1.5

var text = [
	"Let's start again.",
	"Hello my friend. I am Jimmy. And I am a Flag. I like night sky and I am here to help you finish this game. I know it did not go well last time. I already told Kimmy, that you were probably shy. She is not mad about you. Trust is everything in this world. I trust you. Do you trust me? Something tells me you do.",
	"THIS is your goal. It's actually me - Jimmy. What a coincidence!",
	"Still not clear? .. Just come to me. We will win and everyone will be happy.",
	"What are you doing? You don't want to see me happy, right? :( Maybe I could help you!",
	"I will come to you and we will be happy. You will win this game and I will serve my purpose.",
	"Why are you running from me? I thought you are my friend.",
	"Maybe .. what if .. you hate me? But why? I didn't do anything wrong.",
	"I am just a poor yellow flag. And I want you to finish this game, so you can play other great games.",
	"Please stop. This is not funny.",
	"I .. I .. give up :( Maybe my brother can help you. I am a failure.",
	"11"
	]
var actualTextNumber = -1

func _ready():
	$Player.canMove = false
	Global.level = 2
	$Label.visible = false
	$Arrows.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	startTweenWithText(text[getActualNumber()])	
	
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
	if (actualTextNumber == 1):
		$Label.visible = true
	if (actualTextNumber == 2):
		$Player.canMove = true
		$Label.visible = false
		$Arrows.visible = true
		timeToNextText = 10
	if (actualTextNumber == 3):
		pass
	if (actualTextNumber == 4):
		$Arrows.visible = false
		timeToNextText = 1.5
	if (actualTextNumber == 5):
		$Flag.startFollowing = true
	if (actualTextNumber == 11):
		get_tree().change_scene("res://Scenes/Levels/Level_4.tscn")
	pass


func _on_Timer_timeout():
	$Timer.stop()
	$ButtonControl/RichTextLabel.percent_visible = 0
	startTweenWithText(text[getActualNumber()])
