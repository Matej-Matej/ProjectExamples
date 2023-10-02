extends Area2D

var completed = false

func _init():
	add_to_group("multipleObjectiveArea")


func _on_MultipleObjectiveArea_body_entered(body):
	if (body.is_in_group("Player")):
		completed = true
