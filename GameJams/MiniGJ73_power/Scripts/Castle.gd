extends Node2D

var haveBattery = false

var lives = 20
var maxLives = 20

var increasedMaxHp = 0

func _ready():
	add_to_group("CastleUpgrade")
	$AnimationPlayer.play("float")
	pass

func _process(delta):
	$Life.text = str(lives) + "/" + str(maxLives+increasedMaxHp)

func _on_CastleArea_area_entered(area):
	if (area.is_in_group("EnemyRadius")):
		dealDamage(area.get_parent().dealingDamage)
		area.get_parent().queue_free()

func dealDamage(damage):
	lives -= damage
	if (lives <= 0):
		get_parent().get_node("GameOverScreen").visible = true
		get_tree().paused = true

func repair(value):
	lives+=1
	if (lives>=( maxLives+ increasedMaxHp)):
		lives = (maxLives + increasedMaxHp)
