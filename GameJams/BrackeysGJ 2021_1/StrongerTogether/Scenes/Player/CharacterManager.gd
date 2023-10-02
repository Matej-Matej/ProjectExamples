extends Node2D

onready var camera = get_parent().get_node("Camera2D")

func _ready():
	camera.objectToFollow = $Square
	pass
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_square")):
		disableAllCharacters()
		$Square.setActive(true)
		camera.changeObject($Square)
	if (Input.is_action_just_pressed("ui_rectangle")):
		disableAllCharacters()
		$Rectangle.setActive(true)
		camera.changeObject($Rectangle)
	if (Input.is_action_just_pressed("ui_triangle")):
#		disableAllCharacters()
#		$Triangle.setActive(true)
#		camera.changeObject($Triangle)
		pass
	if (Input.is_action_just_pressed("ui_trapeze")):
		disableAllCharacters()
		$Trapeze.setActive(true)
		camera.changeObject($Trapeze)

func disableAllCharacters():
	for child in get_children():
		child.setActive(false)
