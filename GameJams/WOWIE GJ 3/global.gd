extends Node

var level = 0
var music = true
var tweenSpeed = 1
var tweenStep = 0.4
var minTween = 0.3
var maxTween = 10

var speedInc = false

func _ready():
	pass

func _process(delta):
	if (Input.is_action_just_pressed("ui_music")):
		music = !music
	if (Input.is_action_just_pressed("faster")):
		speedInc = true
		tweenSpeed += tweenStep
		if (tweenSpeed >= maxTween):
			tweenSpeed = maxTween
	if (Input.is_action_just_pressed("slower")):
		speedInc = true
		tweenSpeed -= tweenStep
		if (tweenSpeed <= minTween):
			tweenSpeed = minTween
	print(tweenSpeed)
