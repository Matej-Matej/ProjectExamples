extends Node2D

onready var explodingBlock = $ExplodingBlock
onready var animationPlayer = $AnimationPlayer

var exploded = false

func _ready():
	animationPlayer.play("idle")

func _on_Area2D_body_entered(body):
	if (body.is_in_group("player")):
		explodeBlock()

func explodeBlock():
	if (!exploded):
		animationPlayer.play("detonate")

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "detonate"):
		animationPlayer.play("boom")
		exploded = true
	elif (anim_name == "boom"):
		if (is_instance_valid(explodingBlock)):
			explodingBlock.explode()
			explodingBlock.queue_free()
		animationPlayer.stop()
		
			
