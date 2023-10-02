extends KinematicBody2D
class_name PlayerClass

var speed = 500  # speed in pixels/sec
var velocity = Vector2.ZERO


func _physics_process(delta):
	movement()
	velocity = move_and_slide(velocity)

func movement():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed
