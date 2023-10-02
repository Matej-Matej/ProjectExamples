extends Node2D

enum typeOfUpgrade { playerSpeed, playerSpeedWhileCarrying, turretDmg, turretArea, turretBulletSpeed, plusTurret, chanceToDoubleDMG, turretFasterShooting, slowerBatteryDrain, fasterBatteryCharge,plusBattery, batteryIncMaxValue,batteryHealCastle, castleHP, castleRepair }
export (typeOfUpgrade) var type = typeOfUpgrade.playerSpeed
export var iconName = "Name of the icon"
export var description = ""
export(Texture) var iconTexture
export (int,0,10,1) var maxLevel = 2
export var currentLevel = 0
export(Array,int) var pricesPerLevel

func _ready():
	$Sprite.texture = iconTexture

func buy():
	currentLevel += 1
	match(type):
		typeOfUpgrade.playerSpeed:
			for player in get_tree().get_nodes_in_group("PlayerUpgrade"):
				player.increasedSpeed += 0.1 
		typeOfUpgrade.playerSpeedWhileCarrying:
			for player in get_tree().get_nodes_in_group("PlayerUpgrade"):
				player.increasedSpeedWhileCarrying += 0.1 
		typeOfUpgrade.turretDmg:
			for turret in get_tree().get_nodes_in_group("TurretUpgrade"):
				turret.increasedTurretDmg += 1
		typeOfUpgrade.turretBulletSpeed:
			for turret in get_tree().get_nodes_in_group("TurretUpgrade"):
				turret.increasedTurretBulletSpeed += 5
		typeOfUpgrade.plusTurret:
			for level in get_tree().get_nodes_in_group("LevelUpgrade"):
				level.addChild(true,false)
		typeOfUpgrade.turretFasterShooting:
			for turret in get_tree().get_nodes_in_group("TurretUpgrade"):
				turret.increaseShootingRate -= 0.05
		typeOfUpgrade.plusBattery:
			for level in get_tree().get_nodes_in_group("LevelUpgrade"):
				level.addChild(false,true)
		typeOfUpgrade.slowerBatteryDrain:
			for battery in get_tree().get_nodes_in_group("BatteryUpgrade"):
				battery.slowerBatteryDrain += 0.1
		typeOfUpgrade.fasterBatteryCharge:
			for battery in get_tree().get_nodes_in_group("BatteryUpgrade"):
				battery.fasterBatteryCharge += 0.2
		typeOfUpgrade.batteryIncMaxValue:
			for battery in get_tree().get_nodes_in_group("BatteryUpgrade"):
				battery.batteryIncMaxPower += 75
		typeOfUpgrade.castleHP:
			for castle in get_tree().get_nodes_in_group("CastleUpgrade"):
				castle.increasedMaxHp += 1
				castle.repair(1)
		typeOfUpgrade.castleRepair:
			for castle in get_tree().get_nodes_in_group("CastleUpgrade"):
				castle.repair(1)
				currentLevel = 0
