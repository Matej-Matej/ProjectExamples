extends Node2D

const SPEED = 200
	
func _process(delta):
	position.y +=  SPEED * delta
	pass
	
# Ak sa guľka dotkne hráča alebo zeme, odstráni sa
func _on_Area2D_body_entered(body):
	if (body.name == "Player"):
		get_tree().call_group("gameLevels", "hurt" )
		queue_free()
	if (body.name == "TileMap"):
		queue_free()
	pass # Replace with function body.
