extends Node2D

export var next : PackedScene
var hud
var maxObjective = 1
var completedObjectives = 0

func _ready():
	maxObjective = get_tree().get_nodes_in_group("multipleObjectiveArea").size()
	hud = get_tree().get_nodes_in_group("hud")[0]
	$FinalArea.visible = false
	$FinalArea/CollisionShape2D.disabled = true

func _process(delta):
	var count = 0
	for node in get_tree().get_nodes_in_group("multipleObjectiveArea"):
		if (node.completed):
			count += 1
	completedObjectives = count
	$Label2.text = str(completedObjectives) + "/" + str(maxObjective)
	if (completedObjectives == maxObjective):
		$FinalArea.visible = true
		$FinalArea/CollisionShape2D.disabled = false
		set_process(false)
	
func _on_FinalArea_body_entered(body):
	if (body.is_in_group("Player")):
		get_tree().change_scene_to(next)
