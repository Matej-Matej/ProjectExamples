extends Node

const MAX_LIFE = 3
const NUMBER_OF_SCORES = 5

var lifes = MAX_LIFE
var score = 0
var oldScore = 0

var soundEffect = false
var musicEffect = false
var fullScreen = true
var lastLevelName = ""
var bossLevel = false
var highScore = []
var minScore = 0

var isStateUpdated = false
const SAVE_NAME = "savegame.save"
const SCORE_NAME = "score.save"
const GAME_STATE_PATH = "res://Saves/"+SAVE_NAME
const SCORE_PATH = "res://Saves/"+SCORE_NAME

func _ready():
	for i in range(NUMBER_OF_SCORES+1) : highScore.append([0,""])
	var dir = Directory.new()
	var path = OS.get_executable_path().get_base_dir().plus_file("Saves/")
	if dir.open(path) != OK : 
		dir.make_dir(path)
	loadGameState()
	loadScore()
	OS.window_fullscreen = fullScreen
	pass
	
func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
#		saveGameState()
		get_tree().quit()
	
func runLastLevel():
	print(lastLevelName)
	get_tree().change_scene("res://Screens/Levels/"+lastLevelName+".tscn")
	pass

func looseLife():
	lifes -= 1
	gameState.isStateUpdated = true
	if lifes <= 0:
		get_tree().call_group("gameLevels", "die" )
	
func gainLife():
	lifes += 1
	gameState.isStateUpdated = true
	if lifes > MAX_LIFE:
		lifes = MAX_LIFE
		
func addScore(addScore):
	score += addScore
	gameState.isStateUpdated = true
	pass 
	
func isNewScore(scoreValue):
	if minScore > scoreValue:
		return false
	else:
		return true
	
func addHighScore(scoreValue, scoreName):
	for i in range(NUMBER_OF_SCORES):
		if (highScore[i][0] == 0 ):
			highScore[i] = [scoreValue,scoreName]
			highScore.sort_custom(self,"sortFunction")
			minScore = highScore[NUMBER_OF_SCORES-1][0]
			saveScore()
			return
	if isNewScore(scoreValue):
		highScore[NUMBER_OF_SCORES] = [scoreValue,scoreName]
		highScore.sort_custom(self,"sortFunction")
		minScore = highScore[NUMBER_OF_SCORES-1][0]
		highScore[NUMBER_OF_SCORES] = [0,""]
		saveScore()
		
func sortFunction(a, b):
	return a[0] > b[0]
		
func saveScore():
	var save_data = {
		"minScore" : minScore,
		"highScore" : highScore
	}
	var save_game = File.new()
	save_game.open(SCORE_PATH, File.WRITE)
	save_game.store_line(to_json(save_data))
	save_game.close()
	
func loadScore():
	var save_game = File.new()
	if not save_game.file_exists(SCORE_PATH):
		return
	else:
		save_game.open(SCORE_PATH, File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		if (current_line != null):
			minScore = current_line["minScore"]
			highScore = current_line["highScore"]
	return transferToString(highScore)

func transferToString(highScore):
	var text = ""
	if (highScore.size() > 0):
		for i in range(highScore.size()-1):
			text = text + "     " + str(highScore[i][0]) + "     " + str(highScore[i][1]) + "\n"
	return text

func saveGameState():
	var save_data = {
		"soundEffect" : soundEffect,
		"musicEffect" : musicEffect,
		"fullScreen" : fullScreen,
		"lastLevel" : lastLevelName
	}
	var save_game = File.new()
	save_game.open(GAME_STATE_PATH, File.WRITE)
	save_game.store_line(to_json(save_data))
	save_game.close()
	
func loadGameState():
	var save_game = File.new()
	if not save_game.file_exists(GAME_STATE_PATH): return
	else:
		save_game.open(GAME_STATE_PATH, File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		if (current_line != null):
			soundEffect = current_line["soundEffect"]
			musicEffect = current_line["musicEffect"]
			fullScreen = current_line["fullScreen"]
			lastLevelName = current_line["lastLevel"]
	isStateUpdated = true
	
func restartGame():
	lastLevelName = ""
	lifes = MAX_LIFE
	score = 0
	var dir = Directory.new()
	if dir.open("res://Saves/Game") == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while (file_name != ""):
			dir.remove(file_name)
			file_name = dir.get_next()
	else:
		print("Chyba pri pokuse reštartovať hru.")
	pass
