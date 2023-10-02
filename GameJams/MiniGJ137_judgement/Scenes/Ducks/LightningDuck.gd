extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var tween = $Tween
onready var lightningSpaces = $LightningSpaces

var opening
var appeared = false

func _ready():
	if (get_tree().get_nodes_in_group("opening").size() > 0):
		opening = get_tree().get_nodes_in_group("opening")[0]
	animationPlayer.play("idle")
	tween.interpolate_property(self,"position",position,position + Vector2(0,-100),1, Tween.TRANS_LINEAR,Tween.EASE_IN)

func _on_Area2D_body_entered(body):
	if (body.is_in_group("player")):
		startLightning(body)

func startLightning(player):
	if (!appeared):
		animationPlayer.play("goUp")
		openGate()
		appeared = true
	
func openGate():
	opening.open()
	
func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "goUp"):
		animationPlayer.play("fly")
		tween.start()
		enableAllLightningPoints()


func enableAllLightningPoints():
	for i in lightningSpaces.get_children():
		i.appear()
