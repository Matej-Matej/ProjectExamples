extends Camera2D

var objectToFollow


func _ready():
	pass

func _process(delta):
	if (objectToFollow != null):
		position = objectToFollow.position

func changeObject(newObject):
	objectToFollow = newObject
