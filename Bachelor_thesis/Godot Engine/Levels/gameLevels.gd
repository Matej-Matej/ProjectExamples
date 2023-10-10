extends Node2D

var blueGem = false
var greenGem = false
var redGem = false
var star = false

var gameStatePath

func _ready():
	gameStatePath = "res://Saves/Game/"+name+".save"
	var dir = Directory.new()
	var path = OS.get_executable_path().get_base_dir().plus_file("Saves/Game/")
	if dir.open(path) != OK : 
		dir.make_dir(path)
	loadProgress()
	saveProgress()
	gameState.lastLevelName = name
	gameState.saveGameState()
	if (blueGem == true):
		$Gems/gemBlue.visible = false
	if (greenGem == true):
		$Gems/gemGreen.visible = false
	if (redGem == true):
		$Gems/gemRed.visible = false
	add_to_group("gameLevels")
	
func writeToPlayer(text):
	$Player/HUD.write(text)

func pickBlueGem():
	blueGem = true
	
func pickRedGem():
	redGem = true
	
func pickGreenGem():
	greenGem = true
	
func pickStar():
	star = true
	$Collectibles/worldComplete/AnimatedSprite.animation = "waving"
	
func getBlueGem():
	return blueGem
	
func getGreenGem():
	return greenGem
	
func getRedGem():
	return redGem
	
func getStar():
	return star
	
func hurt():
	if (gameState.lifes > 0):
		if $Player/invulnerabilityTimer.is_stopped() == true:
			$Player/invulnerabilityTimer.start()
			gameState.looseLife()
			$Player.hurt()

func heal():
	gameState.gainLife()
	$Player.heal()
	
func die():
	$Player.die()
	
func saveProgress():
	var save_data = {
		"blueGem" : blueGem,
		"greenGem" : greenGem,
		"redGem" : redGem,
		"star" : star,
		"score" : gameState.score
	}
	var save_game = File.new()
	save_game.open(gameStatePath, File.WRITE)
	save_game.store_line(to_json(save_data))
	save_game.close()
	
func loadProgress():
	var save_game = File.new()
	if not save_game.file_exists(gameStatePath):
		return
	else:
		save_game.open(gameStatePath, File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		if (current_line != null):
			blueGem = current_line["blueGem"]
			greenGem = current_line["greenGem"]
			redGem = current_line["redGem"]
			star = current_line["star"]
			gameState.score = current_line["score"]
	gameState.oldScore = gameState.score
	gameState.isStateUpdated = true

func _on_worldComplete_level_completed():
	pass
