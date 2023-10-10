extends Node2D

var maxLettersText
var scoreName
const INPUT_TEXT = "Vložte meno pre uloženie skóre"
const STANDARD_CHAR = "Prosím, vložte iba alfanumerické znaky"
var standardText = false

const WIN_SCREEN = "Gratulujem k výhre"
const LOOSE_SCREN = "Koniec hry"
const normalChar = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNMéýúíóáŕĺťšďľžč0123456789"

func _ready():
	if (not gameState.isNewScore(gameState.score)):
		$score.visible = false
	maxLettersText = "Maximálne "+str($score/inputScore.max_length)+" znakov!"
	$score/warningLabel.text = INPUT_TEXT
	$actualScore.text = "Dosiahnuté skore: " + str(gameState.score)
	if (gameState.lifes <= 0):
		$text.text = LOOSE_SCREN
	else:
		$text.text = WIN_SCREEN

func _on_backToMenuButton_pressed():
	if (standardText and (scoreName != null or scoreName != "") ):
		gameState.addHighScore(gameState.score,scoreName)
		gameState.restartGame()
		get_tree().change_scene("res://Screens/GUI/MenuScreen.tscn")
		
	if (!$score.visible):
		gameState.restartGame()
		get_tree().change_scene("res://Screens/GUI/MenuScreen.tscn")
		


func _on_inputScore_text_changed(new_text):
	var found = false;
	if new_text.length() == 0:
		$score/warningLabel.text = INPUT_TEXT
	if (new_text.length() != 0):
		for newCharacter in new_text:
			found = false
			for character in normalChar:
				if (str(newCharacter) == str(character)):
					standardText = true;
					if new_text.length() < $score/inputScore.max_length:
						$score/warningLabel.text = ""
						scoreName = new_text
					else:
						$score/warningLabel.text = maxLettersText
					found = true
			if (!found):
				standardText = false
				$score/warningLabel.text = STANDARD_CHAR
				break
			


