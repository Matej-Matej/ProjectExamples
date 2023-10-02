extends KinematicBody2D

export var currentCharacter = false
export var speed = 600
export var gravity = 1000
export var jumpSpeed = -700
export var canJump = false

const MAX_JUMP = 1
var jumpCount = 0

var motion = Vector2()
var up = Vector2(0,-1)

var is_walking = false
var is_jumping = false
var eyeDisabilityTime = 3
var textureProgressTime = 0.05
var textureProgressValue = 1

# curses
export var infiniteJumping = false 

export var eyeDisability = false

export var canMoveInAir = false

export var cantGoLeft = false

export var cantSeeInDistance = false

func _ready():
	pass
	
func _physics_process(delta):
	if (currentCharacter):
		if (!visible):
			visible = true
		fall(delta)
		jump()
		move()
		animate()
		if (cantSeeInDistance):
			if (!$CantSee.visible):
				$CantSee.visible = true
		else:
			if (get_node_or_null("CantSee") != null):
				$CantSee.visible = false
		if (eyeDisability): eyeDisability()
		else:
			Global.currentTypeOfColor = Global.typeOfColors.NONE
		get_parent().get_parent().characterPosition = position
		if (canMoveInAir and is_on_floor()): 
			move_and_slide(Vector2(0,motion.y), up)
		else:
			move_and_slide(motion, up)
	else:
		if (visible): visible = false
		if (get_node_or_null("TextureProgress") != null):
			$TextureProgress.value = 0

func eyeDisability():
	if (Global.currentTypeOfColor == Global.typeOfColors.NONE):
		Global.currentTypeOfColor = Global.typeOfColors.RED
		$TextureProgress.modulate = Color.red
		$EyeDisabilityTimer.start(eyeDisabilityTime)
		$textureProgressTimer.start(textureProgressTime)
		$TextureProgress.value += textureProgressValue
	pass

func animate():
	if (is_walking):
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.stop()
		$Sprite.frame = 0
	pass

func move():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = speed
		is_walking = true
		$Sprite.flip_h = false
	elif !cantGoLeft and Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -speed
		is_walking = true
		$Sprite.flip_h = true
	else:
		motion.x = 0
		is_walking = false
	
func fall(delta):
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += gravity * delta

func jump():
	if (infiniteJumping):
		if is_on_floor():
			is_jumping = true
			motion.y = jumpSpeed
	
	if (canJump):
		if (is_on_floor()):
			is_jumping = false
			jumpCount = 0
		if jumpCount < MAX_JUMP and Input.is_action_just_pressed("ui_up"):
			jumpCount += 1
			is_jumping = true
			motion.y = jumpSpeed


func _on_EyeDisabilityTimer_timeout():
	$EyeDisabilityTimer.start(eyeDisabilityTime)	
	Global.changeColor()
	if (Global.currentTypeOfColor == Global.typeOfColors.BLUE):
		$TextureProgress.modulate = Color.blue
	else:
		$TextureProgress.modulate = Color.red
	$TextureProgress.value = 0
	pass # Replace with function body.


func _on_textureProgressTimer_timeout():
	$textureProgressTimer.start(textureProgressTime)
	$TextureProgress.value += textureProgressValue
	pass # Replace with function body.
