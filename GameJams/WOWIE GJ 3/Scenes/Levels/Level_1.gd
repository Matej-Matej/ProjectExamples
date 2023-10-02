extends Node2D

var positiveCircle = preload("res://Assets/circlePositive.png")
var negativeCircle = preload("res://Assets/circleNegative.png")
var positiveCircleCl = preload("res://Assets/circlePosClick.png")
var negativeCircleCl = preload("res://Assets/circleNegClick.png")

var positiveText = "I trust you"
var negativeText = "I dont trust you"

var timeToShowCharacter = 0.1
var timeToNextText = 1.5

var text = [
	"Hello.",
	"I am Jimmy.",
	"Jimmy the Flag. I really like night sky. \nWhat?\nYou like night sky too? That's great. We can be friends.",
	"I've helped a lot of friends like you. They were happy, because they trusted me.",
	"Do you trust me?",
	"You really do!! Wow! I am super excited! Trust is important.",
	"Because I trust you too, let me introduce you to my friend Kimmy. If you click on her, you will win this game.",
	"It sounds hard, I know, but you have to do it if you want to win. You want to win, don't you?",
	"It will be a lot of fun. Everyone will be happy. Just click on Kimmy.\n[color=#ffb42d]P L E A S E[/color] \n",
	"Maybe I start to understand now. It is too hard, right? Wait a second! ..\n                            \n.. maybe I could help you!",
	"I will move the cursor on Kimmy. Then you click on her and we win. We will have so much fun!",
	"Just give me second. I will do that. Than that. Then .. nooo .. back .. yes that looks good.",
	"Now just click. Please. One. Click.",
	"Look, I am not your enemy. I want you to finnish the game and have fun. I am not bad flag :(",
	"You really like when I suffer, don't you? I will try something different. Wait here!",
	"15"
	]
var actualTextNumber = -1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$PositiveButton.visible = false
	$NegativeButton.visible = false
	$Button.visible = false
	startTweenWithText(text[getActualNumber()])	
	
func _process(delta):
	if (Global.music):
		if (!$AudioStreamPlayer2D.playing):	$AudioStreamPlayer2D.play()
	else:
		if ($AudioStreamPlayer2D.playing): $AudioStreamPlayer2D.stop()
#	if (Input.is_action_just_pressed("ui_skip") and actualTextNumber != 11):
##		SKIP TEXT
#		if ($ButtonControl/RichTextLabel.percent_visible != 1):
#			$Tween.stop($ButtonControl/RichTextLabel)
#			$ButtonControl/RichTextLabel.percent_visible = 1
	
	if ($ButtonControl/RichTextLabel.percent_visible == 1):
#		SKIP TO NEXT TEXT
		if (actualTextNumber >= 0 and actualTextNumber != 11 and actualTextNumber != 4):
			if ($ButtonControl/RichTextLabel.percent_visible == 1):
				if ($Timer.is_stopped()):
					$Timer.start(timeToNextText)
	
	if (actualTextNumber <= 9):
		$MouseCursor.global_position = get_global_mouse_position()
	$Tween.playback_speed = Global.tweenSpeed

func makeAction():
	if (actualTextNumber == 4):
		$PositiveButton.visible = true
		$NegativeButton.visible = true
	if (actualTextNumber == 5):
		$PositiveButton.visible = false
		$NegativeButton.visible = false
	if (actualTextNumber == 6):
		$MouseCursor.visible = false
		$Button.visible = true
	if (actualTextNumber == 10):
		timeToShowCharacter = 0.15
	if (actualTextNumber == 11):
		$MouseCursor.visible = true
		$AnimationPlayer.play("moveCursor")
		$AnimationPlayer.playback_speed = Global.tweenSpeed
	if (actualTextNumber == 12):
		timeToShowCharacter = 0.1
	if (actualTextNumber == 13):
		timeToNextText = 5
	if (actualTextNumber == 15):
		timeToNextText = 1.5
		get_tree().change_scene("res://Scenes/Levels/Level_2.tscn")
		
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

func _on_NegativeButton_pressed():
	if ($ButtonControl/RichTextLabel.percent_visible == 1):
		startTweenWithText(text[getActualNumber()])

func _on_NegativeButton_mouse_entered():
	$PositiveButton.texture_normal = negativeCircle
	$PositiveButton.texture_pressed = negativeCircleCl
	$NegativeButton.texture_normal = positiveCircle
	$NegativeButton.texture_pressed = positiveCircleCl
	$NegativeButton.rect_size = Vector2(128,128)
	$PositiveButton.rect_size = Vector2(152,128)

func _on_PositiveButton_pressed():
	if ($ButtonControl/RichTextLabel.percent_visible == 1):
		startTweenWithText(text[getActualNumber()])

func _on_PositiveButton_mouse_entered():
	$PositiveButton.texture_normal = positiveCircle
	$PositiveButton.texture_pressed = positiveCircleCl
	$NegativeButton.texture_normal = negativeCircle
	$NegativeButton.texture_pressed = negativeCircleCl
	$PositiveButton.rect_size = Vector2(128,128)
	$NegativeButton.rect_size = Vector2(152,128)

func _on_Timer_timeout():
	$Timer.stop()
	$ButtonControl/RichTextLabel.percent_visible = 0
	startTweenWithText(text[getActualNumber()])


func _on_AnimationPlayer_animation_finished(anim_name):
	$Timer.start(timeToNextText)
	pass # Replace with function body.
