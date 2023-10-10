extends Area2D

var gemBlue = preload("res://Assets/GFX/Items/gemBlue.png")
var gemGreen = preload("res://Assets/GFX/Items/gemGreen.png")
var gemRed = preload("res://Assets/GFX/Items/gemRed.png")

enum gems {gemBlue, gemGreen, gemRed}
export (gems) var selectedGem

var taken = false

func _ready():
	if (selectedGem == gems.gemBlue):
		$Sprite.texture = gemBlue
	elif (selectedGem == gems.gemGreen):
		$Sprite.texture = gemGreen
	else:
		$Sprite.texture = gemRed
	pass

func free():
	gemBlue.free()
	gemGreen.free()
	gemRed.free()

func _on_gems_body_entered(body):
	if not taken and visible :
		taken = true
		gameState.isStateUpdated = true
		if (gameState.soundEffect) : $pickSFX.play()
		if (selectedGem == gems.gemBlue):
			get_tree().call_group("gameLevels", "pickBlueGem")
		elif (selectedGem == gems.gemGreen):
			get_tree().call_group("gameLevels", "pickGreenGem")
		else:
			get_tree().call_group("gameLevels", "pickRedGem")
		$AnimationPlayer.play("die")
	pass # Replace with function body.



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()
	pass # Replace with function body.
