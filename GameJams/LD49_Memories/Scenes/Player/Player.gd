extends KinematicBody2D

signal editMode(value)

export var SPEED = 400
export var gravity = 1000
export var  JUMP_SPEED = -900
export var boostMultiplier = 2.25
export (Color,RGB) var playerColor = Color("64b964")
const UP = Vector2(0,-1)

var motion = Vector2()

var isOnAxis = Vector2.ZERO

var is_jumping = false
var is_running = false
var editMode = false

var points = 0

var boosting = false

onready var level = get_tree().get_nodes_in_group("Level")[0]

func _ready():
	$Body.modulate = playerColor
	add_to_group("Player")
	add_to_group("Axis")

func _physics_process(delta):
	if (!toogleEditMode()):
		fall(delta)
		jump()
		move()
		animate()
		move_and_slide(motion, UP)
		
func animate() -> void:
	if (is_jumping):
		if (motion.y > 0):
			$AnimationPlayer.play("JumpDown")
		else:
			$AnimationPlayer.play("JumpUp")
	elif (is_running):
		$AnimationPlayer.play("Move")
	else:
		if ($AnimationPlayer.current_animation != "Idle"):
			$AnimationPlayer.play("Idle")
			
func boost() -> void:
	motion.y = boostMultiplier*JUMP_SPEED
	boosting = true
	
func addPoint(point : int) -> void:
	points += point
	$Label.text = str(points)

func is_on_floor():
	return ($GroundChecker/CheckerC.is_colliding() or $GroundChecker/CheckerL.is_colliding() or $GroundChecker/CheckerR.is_colliding())
		
func toogleEditMode():
	if (level.canUseEditMode):
		if (Input.is_action_just_pressed("ui_toogle_edit_mode")):
			editMode = (!editMode and is_on_floor())
			emit_signal("editMode",editMode)
		return editMode
	
func move():	
	if (!is_jumping):
		is_running = true
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -SPEED
	else:
		motion.x = 0
		is_running = false
		
func jump():
	if (boosting):
		is_jumping = true
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
