extends KinematicBody2D

const FLOOR = Vector2(0,1)

var isOnAxis = Vector2.ZERO

export var gravity = 1000
export var SPEED = 120
export var boostValue = -500

var direction = -1

var velocity = Vector2()

func _ready():
	add_to_group("Enemies")
	add_to_group("Axis")

func _physics_process(delta):
	move(delta)
	

func move(delta):
	velocity.x = SPEED * direction

	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, FLOOR)

	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1

	if not $RayCast2D.is_colliding():
		direction = direction * -1
		$RayCast2D.position.x *= -1
