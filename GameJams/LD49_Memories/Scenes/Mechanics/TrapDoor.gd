extends Node2D

onready var tilemap = get_child(4)

func _ready():
	if (tilemap != null):
		$TextureProgress.max_value = tilemap.time*100

func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("down")
	if (body.is_in_group("Player") or body.is_in_group("Enemies")):
		if (tilemap != null):
			tilemap.openDoor()

func _on_Area2D_body_exited(body):
	$AnimationPlayer.play("up")
	if (body.is_in_group("Player") or body.is_in_group("Enemies")):
		if (tilemap != null):
			tilemap.startTimer()
			
			
func _process(delta):
	if (tilemap != null):
		$TextureProgress.value = tilemap.timeLeft()*100
