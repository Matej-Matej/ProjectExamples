extends Area2D

const GOLD_SCORE = 10
const SILVER_SCORE = 5
const BRONZE_SCORE = 1

var coinBronze = preload("res://Assets/GFX/Items/coinBronze.png")
var coinSilver = preload("res://Assets/GFX/Items/coinSilver.png")
var coinGold = preload("res://Assets/GFX/Items/coinGold.png")

enum coins {coinBronze, coinSilver, coinGold}
export (coins) var selectedCoin

var taken = false

func _ready():
	$AnimationPlayer.play("coinFlip")
	if (selectedCoin == coins.coinBronze):
		$Sprite.texture = coinBronze
	elif (selectedCoin == coins.coinSilver):
		$Sprite.texture = coinSilver
	else:
		$Sprite.texture = coinGold

func free():
	coinBronze.free()
	coinSilver.free()
	coinGold.free()


func _on_coins_body_entered(body):
	if taken == false:
		if (gameState.soundEffect) :$pickSFX.play()
		taken = true
		if (selectedCoin == coins.coinBronze):
			gameState.addScore(BRONZE_SCORE)
		elif (selectedCoin == coins.coinSilver):
			gameState.addScore(SILVER_SCORE)
		else:
			gameState.addScore(GOLD_SCORE)
		$AnimationPlayer.play("die")


func _on_coins_body_exited(body):
	queue_free()
	pass # Replace with function body.
