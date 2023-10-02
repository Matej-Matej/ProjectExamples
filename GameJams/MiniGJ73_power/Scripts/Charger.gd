extends Node2D

var haveBattery = false

func _ready():
	$CPUParticles2D.emitting = false
	pass

func _process(delta):
	getCollision()
	
func getCollision():
	haveBattery = false
	var allAreas = $BatteryRadius.get_overlapping_areas()
	for area in allAreas:
		if (area.is_in_group("BatteryRadiusToPut")):
			if(!area.get_parent().isPicked):
				area.get_parent().position = $BatteryPosition.global_position
				haveBattery = true
				area.get_parent().isCharging = true
				if (!$AnimationPlayer.is_playing()):
					$AnimationPlayer.play("startCharging")
	if (!haveBattery and $AnimationPlayer.current_animation == "charging"):
		$AnimationPlayer.play("endCharging")


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "startCharging"):
		$AnimationPlayer.play("charging")
		$CPUParticles2D.emitting = true
	if (anim_name == "endCharging"):
		$CPUParticles2D.emitting = false
