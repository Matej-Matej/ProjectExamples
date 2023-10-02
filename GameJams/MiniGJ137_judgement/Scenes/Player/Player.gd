extends KinematicBody2D

export var enableCamera = true

export var SPEED = 180
export var JUMP_SPEED = -315

export var gravity = 500
const UP = Vector2(0,-1)

var motion = Vector2()

var is_jumping: bool = false
var is_running: bool = false

var spreadFire: bool = false

onready var camera = $Camera2D
onready var animationSprite = $AnimatedSprite

onready var particles1 = $CPUParticles2D
onready var particles2 = $CPUParticles2D2

func _init():
	add_to_group("player")

func _ready():
	if (!enableCamera):
		camera.queue_free()

func _physics_process(delta):
	fall(delta)
	jump()
	move()
	animate()
	move_and_slide(motion, UP)
			
func animate() -> void:
	if (is_jumping):
		animationSprite.play("jump")
	elif (is_running):
		animationSprite.play("move")
	else:
		animationSprite.play("idle")
			
func move():	
	if (!is_jumping):
		particles1.emitting = true
		particles1.emitting = true
		is_running = true
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = SPEED
		animationSprite.flip_h = true
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -SPEED
		animationSprite.flip_h = false
	else:
		motion.x = 0
		particles1.emitting = false
		particles2.emitting = false
		is_running = false
		
func jump():
	if is_on_floor():
		is_jumping = false
	if !is_jumping and Input.is_action_just_pressed("ui_up"):
		is_jumping = true
		motion.y = JUMP_SPEED

func fall(delta):
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += gravity * delta
		
func startFire():
	spreadFire = true
