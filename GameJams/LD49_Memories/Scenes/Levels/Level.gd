extends Node2D

const TILE_SIZE = 512
const CAMERA_SS_EM = 3 # camera smoothing speed edit mode
const CAMERA_SS_DEF = 5 # camera smoothing speed default
var canMove = false
var canExitEditMode = true

export var canUseEditMode = true

export(Color, RGB) var neutralWallColor = Color("0e0e0e")
export(Color, RGB) var trueWallColor = Color("e624af")
export(Color, RGB) var falseWallColor = Color("3df9ea")

export(Color, RGB) var tileColor = Color("5433be")
export(Color, RGB) var backgroundPuzzleMapColor = Color("effafa")

export var title = "Nazov"

export(Texture) var parallaxTexture #650px x 650px

var currentPuzzlePart

var firstInit = false

var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}

func _init():
	add_to_group("Level")

func _ready():
	$Camera2D.smoothing_speed = CAMERA_SS_DEF
	assignCamera()
	roundPuzzlePartPosition()
		
func _physics_process(delta):
	$Camera2D.position = $Player.position
	
func _process(delta):
	
	if (!Global.music):
		if (get_node_or_null("AllPuzzleParts/PuzzlePart2/AudioStreamPlayer") != null):
			if ($AllPuzzleParts/PuzzlePart2/AudioStreamPlayer.playing):
				$AllPuzzleParts/PuzzlePart2/AudioStreamPlayer.stop()
	
	if (!firstInit):
		findPartWhereIsPlayer()
		setWallInPuzzleParts()
		firstInit = true
	
	if (Input.is_action_just_pressed("ui_reset")):
		get_tree().reload_current_scene()
	
func _unhandled_input(event):
	if (canMove):
		for dir in inputs.keys():
			if event.is_action_pressed(dir):
				findPartWhereIsPlayer()
				move(dir)

func roundPuzzlePartPosition():
	for puzzlePart in $AllPuzzleParts.get_children():
		puzzlePart.position = (puzzlePart.position / TILE_SIZE).round()*TILE_SIZE
		puzzlePart.axis = puzzlePart.position / TILE_SIZE

func findPartWhereIsPlayer():
	for puzzlePart in $AllPuzzleParts.get_children():
		puzzlePart.disableAllCollisions(false)

func move(dir):
	if (currentPuzzlePart.move(inputs[dir])):

		currentPuzzlePart.position += inputs[dir] * TILE_SIZE
		currentPuzzlePart.axis = currentPuzzlePart.position / TILE_SIZE
		moveOtherObjects(dir)
		
	isAnotherPuzzleNear()
	setWallInPuzzleParts()
		
		
func moveOtherObjects(dir):
#	PLAYER
	$Player.position +=  inputs[dir] * TILE_SIZE
	
#	ENEMIES, .. 
	for object in get_tree().get_nodes_in_group("Axis"):
		if (object.name != "Player"):
			if (object.isOnAxis == $Player.isOnAxis):
#				object.position += inputs[dir] * TILE_SIZE
				object.position += inputs[dir]
		
#	DESTROY BULLETS, ...
	for bullet in get_tree().get_nodes_in_group("Bullet"):
		bullet.queue_free()
		
#		Kontroluje, či sa nachádza nejaká časť pri okolitých častiach
func isAnotherPuzzleNear():
	canExitEditMode = true
	for puzzlePart in $AllPuzzleParts.get_children():
		puzzlePart.setAllWalls()
		if (canExitEditMode and currentPuzzlePart.axis.x + 1 == puzzlePart.axis.x and currentPuzzlePart.axis.y == puzzlePart.axis.y):
			canExitEditMode = currentPuzzlePart.matchTwoDirections(Vector2.RIGHT,puzzlePart)
		if (canExitEditMode and currentPuzzlePart.axis.x == puzzlePart.axis.x and currentPuzzlePart.axis.y + 1 == puzzlePart.axis.y):
			canExitEditMode = currentPuzzlePart.matchTwoDirections(Vector2.DOWN,puzzlePart)
		if (canExitEditMode and currentPuzzlePart.axis.x - 1 == puzzlePart.axis.x and currentPuzzlePart.axis.y == puzzlePart.axis.y):
			canExitEditMode = currentPuzzlePart.matchTwoDirections(Vector2.LEFT,puzzlePart)
		if (canExitEditMode and currentPuzzlePart.axis.x == puzzlePart.axis.x and currentPuzzlePart.axis.y - 1 == puzzlePart.axis.y):
			canExitEditMode = currentPuzzlePart.matchTwoDirections(Vector2.UP,puzzlePart)

func setWallInPuzzleParts():
	for puzzlePart in $AllPuzzleParts.get_children():
		for secondPart in $AllPuzzleParts.get_children():
			if (puzzlePart.name != secondPart.name):
				if (secondPart.axis.x + 1 == puzzlePart.axis.x and secondPart.axis.y == puzzlePart.axis.y):
					if (secondPart.matchTwoDirections(Vector2.RIGHT,puzzlePart)):
						secondPart.setWall("Right",false)
						puzzlePart.setWall("Left",false)
				if (secondPart.axis.x == puzzlePart.axis.x and secondPart.axis.y + 1 == puzzlePart.axis.y):
					if (secondPart.matchTwoDirections(Vector2.DOWN,puzzlePart)):
						secondPart.setWall("Bottom",false)
						puzzlePart.setWall("Top",false)
				if (secondPart.axis.x - 1 == puzzlePart.axis.x and secondPart.axis.y == puzzlePart.axis.y):
					if (secondPart.matchTwoDirections(Vector2.LEFT,puzzlePart)):
						secondPart.setWall("Left",false)
						puzzlePart.setWall("Right",false)
				if (secondPart.axis.x == puzzlePart.axis.x and secondPart.axis.y - 1 == puzzlePart.axis.y):
					if (secondPart.matchTwoDirections(Vector2.UP,puzzlePart)):
						secondPart.setWall("Top",false)
						puzzlePart.setWall("Bottom",false)


func changeCurrentPuzzlePart(newPart):
	currentPuzzlePart = newPart

func assignCamera():
	if (canMove):
		$Camera2D.smoothing_speed = CAMERA_SS_EM
		$Camera2D.zoom = Global.CAMERA_ZOOM_EM
	else:
		$Camera2D.smoothing_speed = CAMERA_SS_DEF
		$Camera2D.zoom = Global.CAMERA_ZOOM_DEF

func _on_Player_editMode(value):
	canMove = value
	if (value):
		get_tree().paused = true
		$Camera2D.smoothing_speed = CAMERA_SS_EM
		$Camera2D.zoom = Global.CAMERA_ZOOM_EM
	else:
		get_tree().paused = false
		$Camera2D.smoothing_speed = CAMERA_SS_DEF
		$Camera2D.zoom = Global.CAMERA_ZOOM_DEF

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		if (Global.music):
			$AllPuzzleParts/PuzzlePart2/AudioStreamPlayer.play()

func _on_AudioStreamPlayer_finished():
	$AllPuzzleParts/PuzzlePart2/AudioStreamPlayer.stop()
