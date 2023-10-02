extends Node2D
class_name MiniMap

var mapToRealMultiplier = 20

onready var topLeft = $BorderBoundaries/TopLeft
onready var bottomRight = $BorderBoundaries/BottomRight

onready var playerItem = $MiniMapItems/Player
onready var cameraView = $CameraView
var camera = null
var playerItemStartingPosition
var cameraStartingPosition

var isNearPlayerThreshold: int = 25
var isLockedToPlayer: bool = false

func _ready():
	playerItemStartingPosition = playerItem.global_position
	
func addCamera(cam):
	camera = cam
	cameraStartingPosition = camera.global_position

func updatePlayerPosition(playerPosition: Vector2) -> void:
	playerItem.global_position = playerItemStartingPosition + Vector2(playerPosition.x / mapToRealMultiplier, playerPosition.y / mapToRealMultiplier)

func _physics_process(delta):
	var mousePosition = get_global_mouse_position()
	if (isInBackground(mousePosition)):
		cameraView.global_position = mousePosition
		camera.global_position = Vector2(cameraView.position.x * mapToRealMultiplier, cameraView.position.y * mapToRealMultiplier)

func isInBackground(pos: Vector2) -> bool:
	return (pos.x >= topLeft.global_position.x and pos.x <= bottomRight.global_position.x
	and pos.y >= topLeft.global_position.y and pos.y <= bottomRight.global_position.y)

func isNearPlayer(pos: Vector2) -> bool:
	return pos.distance_to(playerItem.global_position) < isNearPlayerThreshold
