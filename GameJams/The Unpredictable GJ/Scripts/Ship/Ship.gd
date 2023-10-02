extends Node2D

var par = 0
var start = false

func _ready():
	$Whole.visible = false
	$CPUParticles2D.emitting = false
	$CPUParticles2D2.emitting = false
	pass

func _process(delta):
	$NotWhole/p1.visible = ParametersGlobal.p1
	$NotWhole/p2.visible = ParametersGlobal.p2
	$NotWhole/p3.visible = ParametersGlobal.p3
	$NotWhole/p4.visible = ParametersGlobal.p4
	$NotWhole/p5.visible = ParametersGlobal.p5
	$NotWhole/p6.visible = ParametersGlobal.p6
	
	if (ParametersGlobal.everythingCollected()):
		$NotWhole.visible = false
		$Whole.visible = true
	
	if (start):
		par += 1
		position.y -= 1
	if par>= 500:
		ParametersGlobal.shipGone = true


func _on_AnimatedSprite_animation_finished():
	start = true
	$CPUParticles2D.emitting = true
	$CPUParticles2D2.emitting = true
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if (body.is_in_group("Player")):
		if (ParametersGlobal.everythingCollected()):
			ParametersGlobal.restartLevel()
			body.stop = true
			body.extendTimer()
			$Whole/AnimatedSprite.play("Deploy")
			body.visible = false
	pass # Replace with function body.
