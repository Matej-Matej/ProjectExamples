extends KinematicBody2D

onready var player = get_owner().get_node("Player")
onready var nav = get_parent().get_node("Navigation2D")

const COLLISION_RADIUS = 1000

var lifes = 1
var speed = 350
var is_dead = false

var path = []
var playerInView = false
var startingPosition

func _ready():
	$AnimatedSprite.play("fly")
	startingPosition = position
	$fieldOfView/CollisionShape2D.shape.radius = COLLISION_RADIUS

func free():
	nav.free()
	player.free()

func _process(delta):
	if (playerInView and $hurtPlayerTimer.is_stopped()):
		_update_navigation_path(position, player.global_position)
		move_along_path(speed * delta)
	else:
		_update_navigation_path(position, startingPosition)
		move_along_path(speed * delta)
	switchDirection()

func _update_navigation_path(start_position, end_position):
	path = nav.get_simple_path(start_position, end_position, true)
	path.remove(0)

# otočí sa podľa toho na ktorej stráne od hráča je 
func switchDirection():
	$AnimatedSprite.flip_h = player.global_position.x < position.x
		
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
	
func hurt():
	if ($invulnerabilityTimer.is_stopped()):
		$invulnerabilityTimer.start()
		lifes -= 1
		dead()
	pass
	
func dead():
	is_dead = true
	$AnimatedSprite.play("dead")

func _on_fieldOfView_body_entered(body):
	if (body.name == "Player"):
		playerInView = true
	pass # Replace with function body.

func _on_fieldOfView_body_exited(body):
	if (body.name == "Player"):
		playerInView = false
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if (body.name == "Player"):
		$hurtPlayerTimer.start()
		get_tree().call_group("gameLevels", "hurt" )
	pass # Replace with function body.

func _on_AnimatedSprite_animation_finished():
	if ($AnimatedSprite.animation == "dead"):
		queue_free()
	pass # Replace with function body.
