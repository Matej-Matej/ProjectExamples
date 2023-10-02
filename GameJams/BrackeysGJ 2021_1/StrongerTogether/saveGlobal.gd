extends Node


var sqPos = Vector2.ZERO
var recPos = Vector2.ZERO
var traPos = Vector2.ZERO

func saveGame():
	for i in get_tree().get_nodes_in_group("playerShapes"):
		if (i.name == "Square"):
			sqPos = i.position
		elif (i.name == "Rectangle"):
			recPos = i.position
		elif (i.name == "Trapeze"):
			traPos = i.position

func _process(delta):
	if (Input.is_action_just_pressed("ui_home")):
		loadGame()

func loadGame():
	for i in get_tree().get_nodes_in_group("playerShapes"):
		if (i.name == "Square"):
			i.position = sqPos
		elif (i.name == "Rectangle"):
			i.position = recPos
		elif (i.name == "Trapeze"):
			i.position = traPos
