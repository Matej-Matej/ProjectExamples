extends Node

enum typeOfColors  { RED, BLUE , NONE }
var currentTypeOfColor = typeOfColors.NONE

func changeColor():
	if (currentTypeOfColor == typeOfColors.RED):
		currentTypeOfColor = typeOfColors.BLUE
	elif (currentTypeOfColor == typeOfColors.BLUE):
		currentTypeOfColor = typeOfColors.RED

var currentLevel = 1

var sound = true

func _ready():
	pass
