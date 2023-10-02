extends KinematicBody2D

export var speed = 400
export var gravity = 1000
export var jumpSpeed = -600
const UP = Vector2(0,-1)
const MAX_JUMP = 2

const JUMP_BOOST = -750

var jumpCount = 0

var direction = true 	# true = vlave ; false = vpravo
var motion = Vector2()

var is_dead = false
var is_walking = false
var is_jumping = false
var is_boosting = false
var canMove = true

func _ready():
	add_to_group("Player")

func _physics_process(delta):
	fall(delta)
	if (canMove):
		jump()
		move()
	else:
		motion.x = 0
	move_and_slide(motion, UP)
				
func move():	
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		direction = false
		$Sprite.flip_h = false
		motion.x = speed
		is_walking = true
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = true
		direction = true
		motion.x = -speed
		is_walking = true
	else:
		motion.x = 0
		is_walking = false


func jump():
	if is_on_floor():
		if (is_boosting):
			is_boosting = false
		else:
			jumpCount = 0
		is_jumping = false
	
	if jumpCount < MAX_JUMP and Input.is_action_just_pressed("ui_up"):
		jumpCount += 1
		is_jumping = true
		motion.y = jumpSpeed

func fall(delta):
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += gravity * delta
		
func boost():
	is_boosting = true
	jumpCount = MAX_JUMP	
	motion.y = JUMP_BOOST 
