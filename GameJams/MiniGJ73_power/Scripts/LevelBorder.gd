extends Node2D



func _on_Area2D_area_entered(area):
	if (area.is_in_group("Bullet")):
		area.get_parent().queue_free()
	pass # Replace with function body.
