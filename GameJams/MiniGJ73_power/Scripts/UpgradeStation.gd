extends Node2D

onready var upgradePanel = get_parent().get_node("UpgradePanel")
var haveBattery = false

func _process(delta):
	getCollision()
	if (haveBattery):
		$Sprite.frame = 1
	else:
		$Sprite.frame = 0
	
func getCollision():
	haveBattery = false
	var allAreas = $BatteryRadius.get_overlapping_areas()
	for area in allAreas:
		if (area.is_in_group("BatteryRadiusToPut")):
			if(!area.get_parent().isPicked):
				area.get_parent().position = $BatteryPosition.global_position
				if area.get_parent().havePower(): 
					haveBattery = true
					area.get_parent().isConnected = true
					
func openPanel():
	upgradePanel.visible = true
	upgradePanel.startTimer()
	get_tree().paused = true
