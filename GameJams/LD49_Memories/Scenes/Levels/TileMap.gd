extends TileMap

onready var level = get_tree().get_nodes_in_group("Level")[0]

func _ready():
	modulate = level.tileColor
