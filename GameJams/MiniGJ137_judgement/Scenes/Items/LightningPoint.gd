extends Node2D

export var isActive = true
export var delay = 0

onready var timer = $Timer
onready var startTimer = $StartTimer
onready var lightning = $AnimationPlayer2
onready var lightningTimer = $LightningTimer
onready var animatedSprite = $AnimatedSprite
onready var animationPlayer = $AnimationPlayer

onready var textureProgress = $TextureProgress

var lightningTime = 3

func _ready():
	randomize()
	textureProgress.max_value = 3*1000
	$Lightning.visible = false
	if (!isActive):
		queue_free()

func _process(delta):
	textureProgress.value = lightningTimer.time_left*1000

func appear():
	if (isActive):
		startTimer.start(delay)
		
func _on_Timer_timeout():
	var randomNum = randi() % 100
	if (randomNum < 15):
		timer.stop()
		animatedSprite.play("default")
	else:
		timer.start(7)

func _on_AnimationPlayer_animation_finished(anim_name):
	animatedSprite.stop()
	timer.start(10)

func _on_LightningTimer_timeout():
	$Lightning.visible = true	
	lightning.play("lightning")
	lightningTimer.start(lightningTime)

func _on_Area2D_body_entered(body):
	if (body.is_in_group("player")):
		get_tree().reload_current_scene()

func _on_StartTimer_timeout():
	startTimer.stop()
	timer.start(7)
	animationPlayer.play("appear")
	lightningTimer.start(lightningTime)
