extends KinematicBody2D

const GRAVITY = 1000
const SPEED = 120
const FLOOR = Vector2(0,1)

var direction = -1
var lifes = 2

var is_dead = false

var velocity = Vector2()

func _ready():
	$AnimatedSprite.play("walk")

func _physics_process(delta):
	move()
	chceckingCollision()

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	
func hurt():
	if ($invulnerabilityTimer.is_stopped()):
		$invulnerabilityTimer.start()
		lifes -= 1
		if lifes > 0:
			$AnimatedSprite.play("hit")
		else:
			dead()
	pass

func move():
	if not is_dead :
		velocity.x = SPEED * direction
		if direction == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false

		velocity.y = GRAVITY
		velocity = move_and_slide(velocity, FLOOR)

		if is_on_wall():
			direction = direction * -1
			$RayCast2D.position.x *= -1

		if not $RayCast2D.is_colliding():
			direction = direction * -1
			$RayCast2D.position.x *= -1

			
func chceckingCollision():
	if not is_dead:
		for i in $Area2D.get_overlapping_bodies().size():
			if ($Area2D.get_overlapping_bodies()[i].name == "Player"):
				get_tree().call_group("gameLevels", "hurt" )

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "dead":
		queue_free()
	if $AnimatedSprite.animation == "hit":
		$AnimatedSprite.play("walk")
	pass # Replace with function body.
