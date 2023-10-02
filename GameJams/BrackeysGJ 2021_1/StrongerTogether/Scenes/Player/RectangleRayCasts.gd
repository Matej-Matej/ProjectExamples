extends Node2D

onready var rectangle = get_parent()

func _process(delta):
	if ($RightRC.is_colliding() or $TopRightRC.is_colliding()):
		rectangle.isOnWall = true
		rectangle.jumpCount = rectangle.MAX_JUMP-1
	elif ($LeftRC.is_colliding() or $TopLeftRC.is_colliding()):
		rectangle.isOnWall = true
		rectangle.jumpCount = rectangle.MAX_JUMP-1
	else:
		rectangle.isOnWall = false
