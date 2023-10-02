extends KinematicBody2D

onready var castle = get_parent().get_node("Castle")
onready var nav = get_parent().get_node("Navigation2D")
onready var parent = get_parent()

export(GlobalParams.typeOfEnemy) var currentType = GlobalParams.typeOfEnemy.normal

export var speed = 30
export var lives = 3
export var score = 50
export var coinsCount = 1
export var dealingDamage = 1

export var lifeIncrement = 1
export var damageIncrement = 1
export var speedIncrement = 1

var path = []

export var canMove = true

func _ready():
	add_to_group("EnemyGroup")
	initialize()

func initialize():
	$NormalEnemy.visible = false
	$FastEnemy.visible = false
	$StrongEnemy.visible = false
	$SplitterEnemy.visible = false
	$CPUParticles2D.emitting = false
	match(currentType):
		GlobalParams.typeOfEnemy.normal:
			speed = 22*speedIncrement
			lives = 8*lifeIncrement
			score = 10
			coinsCount = 3
			dealingDamage = 1 *damageIncrement
			$NormalEnemy.visible = true
			$AnimationPlayer.play("normalEnemyMove")
			pass
		GlobalParams.typeOfEnemy.faster:
			speed = 38*speedIncrement
			lives = 5*lifeIncrement
			score = 25
			coinsCount = 4
			dealingDamage = 2 *damageIncrement
			$FastEnemy.visible = true
			$AnimationPlayer.play("fastEnemyMove")
			pass
		GlobalParams.typeOfEnemy.stronger:
			speed = 15*speedIncrement
			lives = 20*lifeIncrement
			score = 50
			coinsCount = 7
			dealingDamage = 4 *damageIncrement
			$StrongEnemy.visible = true
			$AnimationPlayer.play("strongEnemyMove")
			pass
		GlobalParams.typeOfEnemy.splitter:
			speed = 28*speedIncrement
			lives = 12*lifeIncrement
			score = 75
			coinsCount = 8
			dealingDamage = 6 *damageIncrement
			$SplitterEnemy.visible = true
			$AnimationPlayer.play("splitterMove")
			pass


func _process(delta):
	if (canMove):
		_update_navigation_path(position, castle.global_position)
		move_along_path(speed * delta)

func _update_navigation_path(start_position, end_position):
	path = nav.get_simple_path(start_position, end_position, true)
	path.remove(0)
	
func move_along_path(distance):
	var last_point = position
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		if distance <= distance_between_points:
			if (distance_between_points == 0):
				position = last_point.linear_interpolate(path[0],1)
				return
			else:
				position = last_point.linear_interpolate(path[0], distance / distance_between_points)
				return
			
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	position = last_point

func dealDamage(damage):
	lives = lives - damage
	if (lives <= 0):
		die()

func die():
	parent.score += score
	parent.coins += coinsCount
	if (currentType == GlobalParams.typeOfEnemy.splitter):
		$AnimationPlayer.play("splitterDie")
		canMove = false
	else:
		queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "splitterDie"):
		var random = randi()%100+1
		if (random <= 33):
			$AnimationPlayer.play("splitterToNormal")
		elif (random <= 66):
			$AnimationPlayer.play("splitterToFaster")
		else:
			$AnimationPlayer.play("splitterToStronger")
		pass
	if (anim_name == "splitterToNormal"):
		canMove = true
		currentType = GlobalParams.typeOfEnemy.normal
		initialize()
	if (anim_name == "splitterToFaster"):
		canMove = true
		currentType = GlobalParams.typeOfEnemy.faster
		initialize()
	if (anim_name == "splitterToStronger"):
		canMove = true
		currentType = GlobalParams.typeOfEnemy.stronger
		initialize()
	pass # Replace with function body.
