extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
const SPEED = 250
var direction = false

func _ready():
	$AnimatedSprite.play("moving")
	pass
	
func _physics_process(delta):
	moving()
	checkingCollision()
	
func moving():
	motion.x = 0
	if direction:
		motion.y = -SPEED
	else:
		motion.y = SPEED
	if is_on_floor() and motion.y > 0:
		direction = true	
	if is_on_ceiling():
		direction = false
	move_and_slide(motion, UP)
	
func checkingCollision():
	for i in $Area2D.get_overlapping_bodies().size():
		if ($Area2D.get_overlapping_bodies()[i].name == "Player"):
			get_tree().call_group("gameLevels", "hurt" )



