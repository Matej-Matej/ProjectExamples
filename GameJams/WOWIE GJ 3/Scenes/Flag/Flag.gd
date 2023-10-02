extends Node2D

onready var player = get_parent().get_node("Player")
onready var nav = get_parent().get_node("Navigation2D")
var allPositions = []
var startFollowing = false
var follow = false
var move = false
var speed = 60
var path = []

func _ready():
	$AnimatedSprite.play("default")
	set_physics_process(false)
	pass

func _process(delta):
	if (startFollowing):
		_update_navigation_path(position, player.global_position)
		move_along_path(speed * delta)

func _update_navigation_path(start_position, end_position):
	path = nav.get_simple_path(start_position, end_position, true)
	path.remove(0)
		
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
	

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		get_tree().change_scene("res://Scenes/GameOverScreen.tscn")
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	move = true
	pass # Replace with function body.
