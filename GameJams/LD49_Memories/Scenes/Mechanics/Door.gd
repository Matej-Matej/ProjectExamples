extends TileMap

export var time = 3

func _ready():
	pass

func openDoor():
	$Timer.stop()
	visible = false
	set_collision_layer_bit(1,false)
	set_collision_mask_bit(0,false)

func closeDoor():
	visible = true
	set_collision_layer_bit(1,true)
	set_collision_mask_bit(0,true)
	
func startTimer():
	$Timer.start(time)

func _on_Timer_timeout():
	closeDoor()
	$Timer.stop()
	
func timeLeft():
	return $Timer.time_left
