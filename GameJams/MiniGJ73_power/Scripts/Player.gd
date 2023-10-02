extends KinematicBody2D

export (int) var speed = 210
export (int) var speedWhileCarrying = 130

var velocity = Vector2()
var carryingObject = null
var pickUpSomething = false
var touchingPickUpButton = false
var canDrop = true

var isMoving = false

var increasedSpeed = 1
var increasedSpeedWhileCarrying = 1

func _ready():
	add_to_group("PlayerUpgrade")

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		isMoving = true
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		isMoving = true
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
		isMoving = true
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		isMoving = true
	if (pickUpSomething):
		velocity = velocity.normalized() * (speedWhileCarrying * increasedSpeedWhileCarrying)
	else:
		velocity = velocity.normalized() * (speed * increasedSpeed)

func _physics_process(delta):
	isMoving = false
	get_input()
	if isMoving:
		if ($AnimationPlayer.current_animation != "walk"): $AnimationPlayer.play("walk")
	else:
		if ($AnimationPlayer.current_animation != "idle"): $AnimationPlayer.play("idle")
	velocity = move_and_slide(velocity)

func _process(delta):
	if (Input.is_action_just_released("PickUp")):
		touchingPickUpButton = false
	getColisions()
	if (pickUpSomething):
		if (carryingObject != null):
			carryingObject.position = $CarryingObjectPos.global_position
		if (canDrop and !touchingPickUpButton and Input.is_action_just_pressed("PickUp")):
			pickUpSomething = false
			carryingObject.isPicked = false
			carryingObject = null

func getColisions():
	var haveBatteryInRadius = false
	if (!pickUpSomething):
		var allAreas = $PlayerCollision.get_overlapping_areas()
		for area in allAreas:
			if (area.is_in_group("Battery")):
				haveBatteryInRadius = true
		for area in allAreas:
			if (area.is_in_group("Battery")):
				if(Input.is_action_just_pressed("PickUp")):
					carryingObject = area.get_parent()
					carryingObject.pickUp()
					touchingPickUpButton = true
					pickUpSomething = true
					break
			elif (area.is_in_group("Turret")):
				if(!haveBatteryInRadius and !area.get_parent().haveBattery and Input.is_action_just_pressed("PickUp")):
					carryingObject = area.get_parent()
					carryingObject.isPicked = true
					touchingPickUpButton = true
					pickUpSomething = true
					break
			elif (area.is_in_group("UpgradeStation")):
				if(area.get_parent().haveBattery and Input.is_action_just_pressed("ui_buy")):
					area.get_parent().openPanel()
					break
