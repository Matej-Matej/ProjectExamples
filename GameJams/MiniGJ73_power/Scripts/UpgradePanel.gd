extends Node2D


var timeToCloseWindow = 0.1

var selectedRow = 0
var selectedIcon = 0 
export var canBuy = true

func _ready():
	set_process(false)
	pass

func _process(delta):
	if (Input.is_action_just_pressed("ui_buy")):
		visible = false
		get_tree().paused = false
		set_process(false)
		selectedIcon = 0
		selectedRow = 0
	if (Input.is_action_just_pressed("PickUp") and canBuy):
		var item = $row0.get_child(selectedIcon)
		if (selectedRow == 1):
			item = $row1.get_child(selectedIcon)
		if (item.currentLevel+1 < item.pricesPerLevel.size() and get_parent().coins >= item.pricesPerLevel[item.currentLevel+1]):
			get_parent().coins -= item.pricesPerLevel[item.currentLevel+1]
			item.buy()
	moveToIcons()

func startTimer():
	$TimerToCloseWindow.wait_time = timeToCloseWindow
	$TimerToCloseWindow.start()

func _on_TimerToCloseWindow_timeout():
	$TimerToCloseWindow.stop()
	set_process(true)
	pass # Replace with function body.

func moveToIcons():
	if Input.is_action_just_pressed('ui_right'):
		selectedIcon += 1
		if (selectedIcon > $row0.get_child_count()-1):
			selectedIcon = 0
	if Input.is_action_just_pressed("ui_left"):
		selectedIcon -= 1
		if (selectedIcon < 0):
			selectedIcon = $row0.get_child_count()-1
	if Input.is_action_just_pressed('ui_down'):
		selectedRow += 1
		if (selectedRow > 1):
			selectedRow = 0
	if Input.is_action_just_pressed('ui_up'):
		selectedRow -= 1
		if (selectedRow < 0):
			selectedRow = 1
	focusOnIcon()
		
func focusOnIcon():
	if (selectedRow == 0):
		$IconCursor.position = $row0.get_child(selectedIcon).global_position
	else:
		$IconCursor.position = $row1.get_child(selectedIcon).global_position
	showInfoAboutIcon()

func showInfoAboutIcon():
	var item = $row0.get_child(selectedIcon)
	if (selectedRow == 1):
		item = $row1.get_child(selectedIcon)
	$BuyContainer/IconTexture.texture = item.iconTexture
	$BuyContainer/IconName.text = item.iconName
	if (item.currentLevel+1 < item.pricesPerLevel.size()):
		$BuyContainer/UpgradeCost.text = "Upgrade Cost: " + str(item.pricesPerLevel[item.currentLevel+1])
	else:
		$BuyContainer/UpgradeCost.text = "Maximum Upgrade" 
	$BuyContainer/Money.text = "You have " + str(get_parent().coins) + " coins."
	if (item.currentLevel+1 < item.pricesPerLevel.size() and get_parent().coins < item.pricesPerLevel[item.currentLevel+1]):
		$BuyContainer/IconName2.text = "Space: return to game"
	else:
		$BuyContainer/IconName2.text = "Space: return to game           E: buy"
	for i in $BuyContainer/CurrentLevel.get_child_count():
		if (item.maxLevel != 0):
			if (i <= item.maxLevel):
				$BuyContainer/CurrentLevel.get_child(i).visible = true
				if (i <= item.currentLevel):
					$BuyContainer/CurrentLevel.get_child(i).self_modulate = Color("618b25")
				else:
					$BuyContainer/CurrentLevel.get_child(i).self_modulate = Color.white
			else:
				$BuyContainer/CurrentLevel.get_child(i).visible = false
		else:
			$BuyContainer/CurrentLevel.get_child(i).visible = false


