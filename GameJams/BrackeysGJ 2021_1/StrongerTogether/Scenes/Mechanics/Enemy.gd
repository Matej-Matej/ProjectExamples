extends Node2D

export var vertical = true
export var speed = 3

enum direction { UP,DOWN,LEFT,RIGHT, NONE }
export(direction) var curDir = direction.NONE


func _ready():
	if (vertical):
		curDir = direction.LEFT
	else:
		curDir = direction.UP
		
func _process(delta):
	match(curDir):
		direction.UP:
			position.y += speed
		direction.DOWN:
			position.y -= speed
		direction.LEFT:
			position.x += speed
		direction.RIGHT:
			position.x -= speed


func _on_ChangeDirectionArea_body_entered(body):
	if (body.name == "TileMap"):
		changeDirection()

func changeDirection():
	if (curDir == direction.UP):
		curDir = direction.DOWN
	elif(curDir == direction.DOWN):
		curDir = direction.UP
	elif(curDir == direction.LEFT):
		curDir = direction.RIGHT
	else:
		curDir = direction.LEFT


func _on_Area2D_body_entered(body):
	if (body.is_in_group("playerShapes")):
		SaveGlobal.loadGame()
