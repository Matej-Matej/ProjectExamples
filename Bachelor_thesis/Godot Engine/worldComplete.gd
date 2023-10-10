extends Area2D

export (String, FILE, "*.tscn") var world_scene
signal level_completed

func _ready():
	$AnimatedSprite.playing = true

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" and $AnimatedSprite.animation == "waving":
			emit_signal("level_completed")
			gameState.lifes = gameState.MAX_LIFE
			get_tree().change_scene(world_scene)
				
func changeLevel():
	get_tree().change_scene(world_scene)
