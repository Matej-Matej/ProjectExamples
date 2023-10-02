extends Node2D

export var actualPower = 150
export var maxPower = 150
export var chargeValue = 0.3
export var drainValue = 0.5

var isPicked =  false
var isConnected = false
var isCharging = false

var slowerBatteryDrain = 0
var fasterBatteryCharge = 0
var batteryIncMaxPower = 0

func _ready():
	add_to_group("BatteryUpgrade")
	pass

func _process(delta):
	if (actualPower <= 0):
		if (!$AnimationPlayer.is_playing()): $AnimationPlayer.play("noBattery")
	else:
		if ($AnimationPlayer.is_playing()): $AnimationPlayer.stop()
		if (actualPower == (maxPower + batteryIncMaxPower)):
			$Sprite.frame = 0
		elif (actualPower >= 0.5*(maxPower + batteryIncMaxPower)):
			$Sprite.frame = 1
		else:
			$Sprite.frame = 2
	if (isConnected): drainPower()
	if (isCharging): chargePower(chargeValue + fasterBatteryCharge)

func drainPower():
	actualPower -= (drainValue - slowerBatteryDrain)
	if (actualPower <= 0):
		actualPower = -1
		isConnected = false

func chargePower(pChargeValue):
	actualPower += pChargeValue
	if (actualPower >= (maxPower + batteryIncMaxPower)):
		actualPower = (maxPower + batteryIncMaxPower)

func havePower():
	return actualPower > 0

func pickUp():
	isConnected = false
	isCharging = false
	isPicked = true
	

