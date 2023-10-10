extends Area2D

func _ready():
	$AnimatedSprite.play("moving")

func _on_staticEnemy_body_entered(body):
	if (body.name == "Player"):
		get_tree().call_group("gameLevels", "hurt" )
