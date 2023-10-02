extends Node2D

enum typeOfPlatform{ RED, BLUE , BOTH }
export (typeOfPlatform) var actualType 

enum typeOfMoving { UP, LEFT , STATIC }
export (typeOfMoving) var actualTypeOfMoving

export var movingDistance = 200
var actualMoving = 0
var direction = false


func _ready():
	if (actualType == typeOfPlatform.RED):
		modulate = Color.red
	elif (actualType == typeOfPlatform.BOTH):
		modulate = Color.gold
	else:
		modulate = Color.blue
	pass
	
func _process(delta):
	if actualMoving >= movingDistance:
		actualMoving = 0
		direction = !direction
	if (actualTypeOfMoving == typeOfMoving.UP):
		if (direction):
			position.y +=1
		else:
			position.y -=1
		actualMoving += 1
		pass
	elif (actualTypeOfMoving == typeOfMoving.LEFT):
		if (direction):
			position.x +=1
		else:
			position.x -=1
		actualMoving += 1
		pass
	else:
		pass
	
	if (actualType == typeOfPlatform.RED):
		if (Global.currentTypeOfColor == Global.typeOfColors.RED):
			$Sprite.visible = true
			$CollisionShape2D.disabled = false
		else:
			$Sprite.visible = false
			$CollisionShape2D.disabled = true
	elif (actualType == typeOfPlatform.BOTH):
		if (Global.currentTypeOfColor == Global.typeOfColors.RED or Global.currentTypeOfColor == Global.typeOfColors.BLUE):
			$Sprite.visible = true
			$CollisionShape2D.disabled = false
		else:
			$Sprite.visible = false
			$CollisionShape2D.disabled = true
	else:
		if (Global.currentTypeOfColor == Global.typeOfColors.BLUE):
			$Sprite.visible = true
			$CollisionShape2D.disabled = false
		else:
			$Sprite.visible = false
			$CollisionShape2D.disabled = true
	if (Global.currentTypeOfColor == Global.typeOfColors.NONE):
		$Particles2D.emitting = true
	else:
		$Particles2D.emitting = false
