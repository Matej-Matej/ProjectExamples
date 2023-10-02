extends Node2D

var tutorialText = [
	"This tutorial is created to help you learn basic game mechanics. \nIf you want to skip it, press N (next).",
	"This is turret. Turret shoot enemies.",
	"These are enemies. There are 4 types of enemies in this game. ",
	"First is normal. Second is faster. Third is stronger. And the last one is Boss. When you kill him, he will change randomly to one of the other enemies.",
	"Enemies will not hurt you, but they want to destroy your castle. Bottom right you can see how many HP your castle have.",
	"Now move turret closer to the enemy. You can pick and drop turret by pressing E when you are near turret. Red circle around your turret is shooting range.",
	"Turret can not shoot enemies without battery. Pick battery and drop it inside turret.",
	"Now turret can shoot enemies. Enemies drop coins and increase your score.",
	"The more you use battery, the more discharged it is. You can charge it in charger.",
	"Pick battery from turret and drop it inside charger.",
	"Charger is now working. You can see on your battery 3 levels of charge. Full charge (3bars), More than half charge (2bars) and less than half charge (1bar).",
	"You can also buy upgrades with your coins. Unfortunately, during tutorial it is not possible to buy upgrades, but you can try it anyway. Move the battery to Upgrade machine.",
	"If you did that, the Upgrade machine start working. Go near its display, and press SPACE. You will see all possible upgrades.",
	"Do not worry, when you buy upgrades, the game is paused. So you can spand as much time buying stuff as you want.",
	"Now you know everything. Enemies will come in waves. There is time between waves, but if you want to skip that, press N (next). You will get bonus coins for every skip.",
	"By pressing ENTER you will start your game. Your goal is to survive TWENTY waves. \nThank you for playing my game and have fun!",
	"",
	"",
	""
]

var iteration = -1
var score = 0
var coins = 0

func _ready():
	$Turret.visible = false
	$Enemy.visible = false
	$Enemy2.visible = false
	$Enemy3.visible = false
	$Enemy4.visible = false
	$Castle.visible = false
	$Battery.visible = false
	$Charger.visible = false
	$UpgradeStation.visible = false
	iteration+=1
	showTutorial()
	pass

func _process(delta):
	coins = 0
	score = 0
	if (Input.is_action_just_pressed("ui_new_wave")):
		get_tree().change_scene("res://Scenes/Level1.tscn")
		pass
	if (Input.is_action_just_pressed("enemy_info")):
		iteration+=1
		showTutorial()

func showTutorial():
	if (iteration < tutorialText.size()):
		$GameLabel.text = tutorialText[iteration]
		if (iteration == 1):
			$Turret.visible = true
		if (iteration == 2):
			$Enemy.visible = true
			$Enemy2.visible = true
			$Enemy3.visible = true
			$Enemy4.visible = true
		if (iteration == 4):
			$Castle.visible = true
		if (iteration == 5):
			$Castle.visible = true
			$Enemy2.visible = false
			$Enemy3.visible = false
			$Enemy4.visible = false			
		if (iteration == 6):
			$Battery.visible = true
			$Enemy.canMove = true
			$Enemy.speed = 0
		if (iteration == 8):
			$Charger.visible = true
		if (iteration == 11):
			$UpgradeStation.visible = true
		if (iteration == 16):
			get_tree().change_scene("res://Scenes/Level1.tscn")
	pass
