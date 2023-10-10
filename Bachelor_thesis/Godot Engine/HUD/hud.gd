extends CanvasLayer

var fullHeart = preload("res://Assets/GFX/HUD/hudHeart_full.png")
var emptyHeart = preload("res://Assets/GFX/HUD/hudHeart_empty.png")

var gemBlue = preload("res://Assets/GFX/HUD/hudJewel_blue.png")
var gemGreen = preload("res://Assets/GFX/HUD/hudJewel_green.png")
var gemRed = preload("res://Assets/GFX/HUD/hudJewel_red.png")
var gemBlueEmpty = preload("res://Assets/GFX/HUD/hudJewel_blue_empty.png")
var gemGreenEmpty = preload("res://Assets/GFX/HUD/hudJewel_green_empty.png")
var gemRedEmpty = preload("res://Assets/GFX/HUD/hudJewel_red_empty.png")

var actualLevel
var soundPlayer

func _ready():
	gameState.isStateUpdated = true
	soundPlayer = AudioStreamPlayer.new()
	add_child(soundPlayer)
	soundPlayer.stream = load("res://Assets/SFX/background.ogg")
	soundPlayer.volume_db = -20
	$Control/Gems/blueGem.texture = gemBlueEmpty
	$Control/Gems/greenGem.texture = gemGreenEmpty
	$Control/Gems/redGem.texture = gemRedEmpty
	$Control/AnimatedSprite.play("idle")
	actualLevel = get_parent().owner
	$Control/LevelText/LevelTextLabel.text = str(actualLevel.name)
	$Control/LevelText/Timer.start()
	update()
	
func free():
	fullHeart.free()
	emptyHeart.free()
	gemBlue.free()
	gemRed.free()
	gemGreen.free()
	gemBlueEmpty.free()
	gemGreenEmpty.free()
	gemRedEmpty.free()
	soundPlayer.free()
	
	
func _process(delta):
	if $Control/LevelText/Timer.time_left == 0: $Control/LevelText/LevelTextLabel.text = ""
	if gameState.isStateUpdated:
		gameState.isStateUpdated = false
		update()
		if (gameState.musicEffect):
			if (!soundPlayer.playing): soundPlayer.play()
		else:
			soundPlayer.playing = false
		if gameState.bossLevel:
			$Control/Gems.visible = false
		else:
			$Control/Gems.visible = true
	if (Input.is_action_just_pressed("ui_pause")):
		if ($PauseScreen.visible) :
			$PauseScreen.visible = false	
		else:
			$PauseScreen.visible = true	
	
func write(text):
	$Control/informationText.text = text
	
func update():
	setLifes()
	setGems()
	setStar()
	setScore()

func setScore():
	$Control/score.text = str(gameState.score)

func setLifes():
	$Control/heart1.texture = emptyHeart
	$Control/heart2.texture = emptyHeart
	$Control/heart3.texture = emptyHeart
	var lifes = gameState.lifes
	if (lifes > 0):
		$Control/heart1.texture = fullHeart
	if (lifes > 1):
		$Control/heart2.texture = fullHeart
	if (lifes > 2):
		$Control/heart3.texture = fullHeart
		
func setGems():
	if (actualLevel.getBlueGem()):
		$Control/Gems/blueGem.texture =  gemBlue
	if (actualLevel.getGreenGem()):
		$Control/Gems/greenGem.texture = gemGreen
	if (actualLevel.getRedGem()):
		$Control/Gems/redGem.texture = gemRed
	
func setStar():
	if (actualLevel.getStar()):
		$Control/AnimatedSprite.play("waving")