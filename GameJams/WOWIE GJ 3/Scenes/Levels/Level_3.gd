extends Node2D

var flagChild = preload("res://Scenes/Flag/FlagChild.tscn")
var spawnEnemyTimer = 1

var timeToShowCharacter = 0.05
var timeToNextText = 2

var text = [
	"Hello.",
	"I am Jerry.",
	"Jerry the narrator.",
	"I already helped millions like you and nobody complained. Everyone was happy, because they trusted me. ",
	"Do you trust me?",
	"You really do!! That is great! Trust is important.",
	"Because i trust you too i can give you very important task. Now click on the red button.",
	"When you click the red button, you will win! .. You want to win, do you?",
	"Dont be shy, i know you can do it!",
	"I understand now. It was too hard for you, right? ",
	"Maybe now it will be easier. I will move the cursor on the red button YOU was supposed to click.",
	"Just give me second. I will do that. Than that. Then .. no no .. back .. yes that looks good.",
	"now just click it.",
	"One. Click.",
	"ok ok, i will try something different. maybe this was not for you.",
	"15"
	]
var actualTextNumber = -1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	startTweenWithText(text[getActualNumber()])	
	$SpawnEnemy.start(spawnEnemyTimer)
	pass

func _process(delta):
	if (Input.is_action_just_pressed("ui_skip") and actualTextNumber != 11):
#		SKIP TEXT
		if ($ButtonControl/RichTextLabel.percent_visible != 1):
			$Tween.stop($ButtonControl/RichTextLabel)
			$ButtonControl/RichTextLabel.percent_visible = 1
	
	if ($ButtonControl/RichTextLabel.percent_visible == 1):
#		SKIP TO NEXT TEXT
		if (actualTextNumber >= 0 and actualTextNumber != 11 and actualTextNumber != 4):
			if ($ButtonControl/RichTextLabel.percent_visible == 1):
				if ($Timer.is_stopped()):
					$Timer.start(timeToNextText)

func _on_killFlagArea_area_entered(area):
	if (area.get_parent().is_in_group("FlagChild")):
		area.get_parent().queue_free()
	pass # Replace with function body.

func _on_SpawnEnemy_timeout():
	randomize()
	var newEnemy = flagChild.instance()
	newEnemy.global_position = $Positions.get_child(randi()%($Positions.get_child_count()-1)+1).global_position
	newEnemy.falling = true
	newEnemy.speed = 2
	$FlagChildren.add_child(newEnemy)
	pass # Replace with function body.

func getActualNumber():
	actualTextNumber += 1
	if (actualTextNumber < text.size()):
		return actualTextNumber
	return text.size()-1
	
func startTweenWithText(text):
	$ButtonControl/RichTextLabel.text = str(actualTextNumber) + "  " + text
	$Tween.interpolate_property($ButtonControl/RichTextLabel, "percent_visible",0, 1,timeToShowCharacter*text.length(),Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	makeAction()
	
func makeAction():
	pass


func _on_Timer_timeout():
	$Timer.stop()
	$ButtonControl/RichTextLabel.percent_visible = 0
	startTweenWithText(text[getActualNumber()])
