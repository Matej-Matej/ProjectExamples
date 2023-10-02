extends Node2D

const ENEMY = preload("res://Scenes/Enemy.tscn")
const TURRET = preload("res://Scenes/Turret.tscn")
const BATTERY = preload("res://Scenes/Battery.tscn")

var timeBetweenWaves = 25
var timeBetweenMonsters = 1.75

var currentWave = 1
var increment = -1
var score = 0
var coins = 0
var firstSpawner = true

export var scorePerWave = 100
export var coinPerSkip = 4

var canSkip = false

var enemiesWave = [
	"",
	"000",
	"0c00",
	"c004c00",
	"00c0000",
	"0c40c40c40c40c40",
	"00441",
	"1000",
	"c14c004c11",
	"1114c111",
	"0001c400014c0001",
	"00411442",
	"001422c001",
	"114c12c422c42",
	"22222",
	"222c4222c4222",
	"004c43",
	"01c01c01c01",
	"12c222222c443",
	"012c001122",
	"000003c4411113c442223c443c3",
]

func _ready():
	add_to_group("LevelUpgrade")
	$WinScreen.visible = false
	$TimerBetweenMonsters.start(timeBetweenMonsters)
	
func _process(delta):
	$score2.text = str(score)
	$coins2.text = str(coins)
	$WaveInfo2.text = "Current wave: " + str(currentWave)
	$timeWave.text = "Next wave in: " + str(stepify($TimerBetweenWaves.time_left,1)) + " seconds."
	if (canSkip and Input.is_action_just_pressed("ui_new_wave")):		
		canSkip = false
		coins += coinPerSkip
		$TimerBetweenWaves.stop()
		$TimerBetweenWaves.start(0.01)
	
func addChild(isTurret , isBattery):
	if (isTurret):
		var newTurret = TURRET.instance()
		for turret in get_tree().get_nodes_in_group("TurretUpgrade"):
			newTurret.increasedTurretDmg = turret.increasedTurretDmg
			newTurret.increasedTurretBulletSpeed = turret.increasedTurretBulletSpeed
			newTurret.increaseShootingRate = turret.increaseShootingRate
		newTurret.position = $Spawners/Position2D.position
		add_child(newTurret)
	if (isBattery):
		var newBattery = BATTERY.instance()
		for battery in get_tree().get_nodes_in_group("BatteryUpgrade"):	
			newBattery.slowerBatteryDrain = battery.slowerBatteryDrain
			newBattery.fasterBatteryCharge = battery.fasterBatteryCharge
			newBattery.batteryIncMaxPower = battery.batteryIncMaxPower
		newBattery.position = $Spawners/Position2D2.position
		add_child(newBattery)
	
func spawnEnemy():
	var letter =  enemiesWave[currentWave][increment]
	match(letter):
		"0":
			var newEnemy = ENEMY.instance()
			newEnemy.currentType = GlobalParams.typeOfEnemy.normal
			if (currentWave > 10):
				newEnemy.lifeIncrement = 1.25
			if (currentWave > 15):
				newEnemy.speedIncrement = 1.25
			if (currentWave > 20):
				newEnemy.damageIncrement = 1.5
			if (currentWave > 25):
				newEnemy.lifeIncrement = 1.5
			if (firstSpawner):
				newEnemy.position = $Spawners/FirstSpawner.position
			else:
				newEnemy.position = $Spawners/SecondSpawner.position
			add_child(newEnemy)
		"1":
			var newEnemy = ENEMY.instance()
			newEnemy.currentType = GlobalParams.typeOfEnemy.faster
			newEnemy.initialize()
			if (currentWave > 10):
				newEnemy.lifeIncrement = 1.25
			if (currentWave > 15):
				newEnemy.speedIncrement = 1.25
			if (currentWave > 20):
				newEnemy.damageIncrement = 1.5
			if (currentWave > 25):
				newEnemy.lifeIncrement = 1.5
			if (firstSpawner):
				newEnemy.position = $Spawners/FirstSpawner.position
			else:
				newEnemy.position = $Spawners/SecondSpawner.position
			add_child(newEnemy)
		"2":
			var newEnemy = ENEMY.instance()
			newEnemy.currentType = GlobalParams.typeOfEnemy.stronger
			newEnemy.initialize()
			if (currentWave > 10):
				newEnemy.lifeIncrement = 1.25
			if (currentWave > 15):
				newEnemy.speedIncrement = 1.25
			if (currentWave > 20):
				newEnemy.damageIncrement = 1.5
			if (currentWave > 25):
				newEnemy.lifeIncrement = 1.5
			if (firstSpawner):
				newEnemy.position = $Spawners/FirstSpawner.position
			else:
				newEnemy.position = $Spawners/SecondSpawner.position
			add_child(newEnemy)
		"3":
			var newEnemy = ENEMY.instance()
			newEnemy.currentType = GlobalParams.typeOfEnemy.splitter
			if (currentWave > 10):
				newEnemy.lifeIncrement = 1.25
			if (currentWave > 15):
				newEnemy.speedIncrement = 1.25
			if (currentWave > 20):
				newEnemy.damageIncrement = 1.5
			if (currentWave > 25):
				newEnemy.lifeIncrement = 1.5
			if (firstSpawner):
				newEnemy.position = $Spawners/FirstSpawner.position
			else:
				newEnemy.position = $Spawners/SecondSpawner.position
			add_child(newEnemy)
		"3":
			pass
		"c":
			firstSpawner = !firstSpawner
			pass
	pass

func _on_TimeBetweenMonsters_timeout():
	$TimerBetweenMonsters.start(timeBetweenMonsters)
	increment += 1
	if (increment >= enemiesWave[currentWave].length()):
		$TimerBetweenMonsters.stop()
		$TimerBetweenWaves.start(timeBetweenWaves)
		canSkip = true
	else:
		spawnEnemy()



func _on_TimerBetweenWaves_timeout():
	$TimerBetweenWaves.stop()
	$TimerBetweenMonsters.start(timeBetweenMonsters)
	canSkip = false
	increment = -1
	firstSpawner = true
	currentWave +=1	
	score += scorePerWave
	if (currentWave >= enemiesWave.size()):
		$WinScreen.visible = true
		get_tree().paused = true
	pass # Replace with function body.
