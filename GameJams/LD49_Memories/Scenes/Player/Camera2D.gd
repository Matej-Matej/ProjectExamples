extends Camera2D

export (Texture) var cpuTexture
export (Color) var startColor = Color("f9a875")
export (Color) var endColor = Color("fff6d3")
export (int) var tweenTime

export var isParticlesActive = true

onready var cpuParticles = $CPUParticles2D
onready var colorRect = $ColorRect
onready var tween = $Tween

func _init():
	add_to_group("Camera")

func _ready():
	cpuParticles.texture = cpuTexture
	tween.interpolate_property(colorRect,"color",startColor,endColor,tweenTime,Tween.TRANS_LINEAR)
	tween.start()
	if (!isParticlesActive):
		cpuParticles.emitting = false

func _process(delta):
	if (Global.music):
		if (!$AudioStreamPlayer2.playing):
			$AudioStreamPlayer2.play(Global.timeMusic)
	else:
		if ($AudioStreamPlayer2.playing):
			Global.timeMusic = $AudioStreamPlayer2.get_playback_position()
			$AudioStreamPlayer2.stop()

func saveStreamPlayerPosition(): 
	Global.timeMusic =  $AudioStreamPlayer2.get_playback_position()

func _on_Tween_tween_all_completed():
	if (colorRect.color == endColor):
		tween.interpolate_property(colorRect,"color",endColor,startColor,tweenTime,Tween.TRANS_LINEAR)
	else:
		tween.interpolate_property(colorRect,"color",startColor,endColor,tweenTime,Tween.TRANS_LINEAR)
	tween.start()	
