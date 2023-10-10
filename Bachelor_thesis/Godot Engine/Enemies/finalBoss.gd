extends KinematicBody2D

var isImmortal = false
var timeout = false
const BULLET = preload("res://Screens/Enemies/bullet.tscn")
var lifes = 3
var is_dead = false
var shipDamaged_1 = preload("res://Assets/GFX/Enemies/shipPink_damage.png")
var shipDamaged_2 = preload("res://Assets/GFX/Enemies/shipPink_damage1.png")

func _ready():
	randomize()
	gameState.bossLevel = true
	gameState.isStateUpdated = true
	$AnimationPlayer.play("MoveDown")
	pass
	
func free():
	BULLET.free()
	shipDamaged_1.free()
	shipDamaged_2.free()

func _process(delta):
	if not is_dead: 
		shooting()

func changeSprite():
	if (lifes == 2): $sprites/spaceShip.texture = shipDamaged_1
	elif (lifes == 1): $sprites/spaceShip.texture = shipDamaged_2

# Boss striela stále pokiaľ je v fázy "Attacking" , medzi každou streľou sa odráta Timer náhodnej dĺžky ( 0-1 sec ) 
func shooting():
	if $AnimationPlayer.current_animation == "Attacking" and not timeout:
		$BulletShooting/Timer.wait_time = randf()
		$BulletShooting/Timer.start()
		if (gameState.soundEffect) : $shootSFX.play()
		timeout = true
		var bullet = BULLET.instance()
		get_tree().get_root().add_child(bullet)
		bullet.position = $BulletShooting/Position2D.global_position
	pass

# Zaručí, že keď sa jedna animácia skončí, nastane druhá 
func _on_AnimationPlayer_animation_finished(anim_name):
	if not is_dead:
		if anim_name == "Attacking":
			$AnimationPlayer.play("MoveDown")
			isImmortal = false
		elif anim_name == "MoveDown":
			$AnimationPlayer.play("MoveBack")
			isImmortal = true
		elif anim_name == "MoveBack":
			$AnimationPlayer.play("Attacking")
			isImmortal = true
		elif anim_name == "hit":
			$AnimationPlayer.play("MoveBack")
	else:
		if anim_name == "dead":
			get_tree().change_scene("res://Screens/GUI/GameOverScreen.tscn")
			queue_free()

func _on_Timer_timeout():
	timeout = false
	pass # Replace with function body.
	
func dead():
	is_dead = true
	gameState.bossLevel = true
	$AnimationPlayer.play("dead")
	
func hurt():
	if not isImmortal:
		isImmortal = true
		lifes -= 1
		if lifes > 0:
			$AnimationPlayer.play("hit")
			changeSprite()
		else:
			dead()
	pass
