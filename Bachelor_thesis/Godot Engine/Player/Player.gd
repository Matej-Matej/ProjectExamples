extends KinematicBody2D

const SPEED = 600
const GRAVITY = 1000
const JUMP_SPEED = -700
const UP = Vector2(0,-1)
const MAX_JUMP = 2

const BOOST_MULTIPLIER = 2

var jumpCount = 0

var direction = true 	# true = vlave ; false = vpravo
var motion = Vector2()

var is_dead = false
var is_running = false
var is_attacking = false
var is_jumping = false

func _ready():
	$AnimatedSprite.flip_h = false
	$AnimatedSprite/weaponArea/leftWeaponCollision.disabled = true
	$healingEffect/Particles2D.emitting = false

func _physics_process(delta):
	if (is_dead == false):
		animate()
		fall(delta)
		jump()
		move()
		attack()
# warning-ignore:return_value_discarded
		move_and_slide(motion, UP)
	
func animate():
	if is_attacking :
		$AnimatedSprite.play("attack")
	elif is_jumping:
		$AnimatedSprite.play("jump")
	elif is_running:
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
	
func move():
	var changeDirection = false
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left") and not is_attacking:
		if direction : changeDirection = true
		direction = false
		if not is_attacking: 
			motion.x = SPEED
			is_running = true
		$AnimatedSprite.flip_h = direction
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right") and not is_attacking:
		if not direction : changeDirection = true
		direction = true
		if not is_attacking: 
			motion.x = -SPEED
			is_running = true
		$AnimatedSprite.flip_h = direction
	else:
		motion.x = 0
		is_running = false
	if changeDirection:
		changeDirection = false
		if direction:
			$AnimatedSprite/weaponArea/leftWeaponCollision.disabled = false
			$AnimatedSprite/weaponArea/rightWeaponCollision.disabled = true
		else:
			$AnimatedSprite/weaponArea/leftWeaponCollision.disabled = true
			$AnimatedSprite/weaponArea/rightWeaponCollision.disabled = false
			
		
func attack():
	if Input.is_action_pressed("ui_attack"):
		is_attacking = true
		attackingCollision()
	else:
		is_attacking = false
	
func attackingCollision():
	var collider = 	$AnimatedSprite/weaponArea.get_overlapping_bodies()
	for object in collider:
		
		if (object.is_in_group("Enemies")):
			object.hurt()

func jump():
	if is_on_floor():
		jumpCount = 0
		is_jumping = false
	
	if jumpCount < MAX_JUMP and Input.is_action_just_pressed("ui_up"):
		if (gameState.soundEffect) : $SoundEffects/jumpSFX.play()
		jumpCount += 1
		is_jumping = true
		motion.y = JUMP_SPEED

func fall(delta):
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY * delta

func heal():
	if (gameState.soundEffect) : $SoundEffects/healSFX.play()
	$healingEffect/Particles2D.emitting = true
	pass

func boost():
	jumpCount = 0	
	motion.y = JUMP_SPEED * BOOST_MULTIPLIER 

func hurt():
	$AnimationPlayer.play("hit")
	if (gameState.soundEffect) : $SoundEffects/hurtSFX.play()
	pass

func die():
	is_dead = true
	$AnimatedSprite.play("dead")
	pass

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	if $AnimatedSprite.animation == "dead":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Screens/GUI/GameOverScreen.tscn")

	pass # Replace with function body.


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.stop()
	pass # Replace with function body.
