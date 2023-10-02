extends Node2D
class_name MainGame

onready var player = $Player
onready var camera = $Camera2D
onready var miniMap = $Camera2D/MiniMap
onready var infoPart = $Camera2D/InfoPart

func _ready():
	miniMap.addCamera(camera)

func _process(delta):
	miniMap.updatePlayerPosition(player.global_position)
