extends Area2D

export (String, MULTILINE) var text

func _on_Sign_body_entered(body):
	get_tree().call_group("gameLevels", "writeToPlayer", text)

func _on_Sign_body_exited(body):
	get_tree().call_group("gameLevels", "writeToPlayer", "")
