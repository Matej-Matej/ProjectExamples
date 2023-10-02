extends KinematicBody2D

const BOOST_MULTIPLIER = 2

export var speed = 200
export var gravity = 500
export var jumpSpeed = -275

const MAX_JUMP = 1
var jumpCount = 0

var motion = Vector2()
var up = Vector2(0,-1)

var is_walking = false
var is_jumping = false

var canJump = true

export var levelRestartTime = 60

export var stop = false

func extendTimer():
	$LevelRestart/Timer.start(500)

func _ready():
	
	stop = false
	$Camera2D/Text.visible = false
	$LevelRestart/Timer.wait_time = levelRestartTime
	$LevelRestart/Timer.start()
	add_to_group("Player")

func _physics_process(delta):
	if (!stop):
		if (Input.is_action_just_pressed("ui_restart")):
			_on_TextureButton_pressed()
		if (ParametersGlobal.gravityChanged): 
			up = Vector2(0,1)
			jumpSpeed = 0.15+(abs(jumpSpeed))
			gravity = -(abs(gravity))
		else:
			up = Vector2(0,-1)
			jumpSpeed = -abs(jumpSpeed)
			gravity = abs(gravity)
		fall(delta)
		if (ParametersGlobal.canJump): jump()
		move()
		animate()
		move_and_slide(motion, up)
	$Camera2D/Clock/Label .text = str(round($LevelRestart/Timer.time_left))
	$Camera2D/Clock/Stick.rotation_degrees += 0.2
	if (ParametersGlobal.everythingCollected()):
		setText("Go to the ship.")
func animate():
	if (is_walking):
		$AnimationPlayer.play("Walking")
	else:
		$AnimationPlayer.play("Idle")
	pass

func move():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = speed
		is_walking = true
		if (!ParametersGlobal.mirrorLevel): $Sprite.flip_h = false
		else:
			if (ParametersGlobal.rotateLevel): $Sprite.flip_h = false
			else: $Sprite.flip_h = true
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -speed
		is_walking = true
		if (!ParametersGlobal.mirrorLevel): $Sprite.flip_h = true
		else:
			if (ParametersGlobal.rotateLevel): $Sprite.flip_h = true
			else: $Sprite.flip_h = false
	else:
		motion.x = 0
		is_walking = false
	
func fall(delta):
	if (!ParametersGlobal.gravityChanged):
		if is_on_floor() and motion.y > 0:
			motion.y = 0
		elif is_on_ceiling():
			motion.y = 1
		else:
			motion.y += gravity * delta
	else:
		if is_on_floor() :
			motion.y = 1
		elif is_on_ceiling() and motion.y > 0:
			motion.y = 0
		else:
			motion.y += gravity * delta

func jump():
	if (canJump):
		if (is_on_floor()):
			is_jumping = false
			jumpCount = 0
		if jumpCount < MAX_JUMP and Input.is_action_just_pressed("ui_up"):
			jumpCount += 1
			is_jumping = true
			motion.y = jumpSpeed

func boost():
	jumpCount = 0	
	motion.y = jumpSpeed * BOOST_MULTIPLIER 


func _on_Timer_timeout():
	_on_TextureButton_pressed()
	$Camera2D/AnimationPlayer.play("Restart")
	$LevelRestart/Timer.stop()
	pass # Replace with function body.

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "Restart"):
		ParametersGlobal.restartLevel()
		get_parent().get_parent().get_tree().reload_current_scene()
		$Camera2D/Clock/Stick.rotation_degrees = 0
		$Camera2D/Clock/Label.visible = true
		$LevelRestart/Timer.wait_time = levelRestartTime
		$LevelRestart/Timer.start()
	pass # Replace with function body.


func _on_TextureButton_pressed():
	$Camera2D/AnimationPlayer.play("Restart")
	$Camera2D/Clock/Label.visible = false
	$LevelRestart/Timer.stop()
	pass # Replace with function body.

func setText(text):
	$Camera2D/Text.visible = true
	$Camera2D/Text/Label2.text = text
	$Camera2D/Text/Timer.start(5)


func _on_Timer2_timeout():
	$Camera2D/Text.visible = false
	pass # Replace with function body.
