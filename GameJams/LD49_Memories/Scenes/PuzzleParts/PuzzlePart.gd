extends Node2D

enum directionsENUM { TRUE,NEUTRAL,FALSE }

export(directionsENUM) var topDir = directionsENUM.NEUTRAL
export(directionsENUM) var bottomDir = directionsENUM.NEUTRAL
export(directionsENUM) var leftDir = directionsENUM.NEUTRAL
export(directionsENUM) var rightDir = directionsENUM.NEUTRAL

export var hasPlayer = false

var axis = Vector2.ZERO

onready var actualLevel = get_tree().get_nodes_in_group("Level")[0]

func _ready():
	setWallColors()
	setWallVisibility()
	$ColorRect.color = actualLevel.backgroundPuzzleMapColor
	if (hasPlayer):
		actualLevel.get_node("Player").isOnAxis = axis
		actualLevel.changeCurrentPuzzlePart(self)
	
func setWallColors():
	for i in $Clone/sides.get_child_count():
		for j in $Clone/sides.get_child(i).get_child_count():
			if (j == 0): 
				$Clone/sides.get_child(i).get_child(j).modulate = actualLevel.neutralWallColor
				$Clone/sides.get_child(i).get_child(j).visible = true
			elif (j == 1):
				$Clone/sides.get_child(i).get_child(j).modulate = actualLevel.trueWallColor
				$Clone/sides.get_child(i).get_child(j).visible = false
			else:
				$Clone/sides.get_child(i).get_child(j).modulate = actualLevel.falseWallColor
				$Clone/sides.get_child(i).get_child(j).visible = false
	
func setWallVisibility():
	match (topDir):
		directionsENUM.TRUE:
			$Clone/sides/Top/topTRUE.visible = true
			pass
		directionsENUM.FALSE:
			$Clone/sides/Top/topFALSE.visible = true
			pass
	match (bottomDir):
		directionsENUM.TRUE:
			$Clone/sides/Bottom/bottomTRUE.visible = true
			pass
		directionsENUM.FALSE:
			$Clone/sides/Bottom/bottomFALSE.visible = true
			pass
	match (leftDir):
		directionsENUM.TRUE:
			$Clone/sides/Left/leftTRUE.visible = true
			pass
		directionsENUM.FALSE:
			$Clone/sides/Left/leftFALSE.visible = true
			pass
	match (rightDir):
		directionsENUM.TRUE:
			$Clone/sides/Right/rightTRUE.visible = true
			pass
		directionsENUM.FALSE:
			$Clone/sides/Right/rightFALSE.visible = true
			pass
	
func getDirectionsENUM():
	return directionsENUM

func disableAllCollisions(value):
	for i in $Collision.get_children():
		i.get_child(0).set_deferred("disabled",value)
		
func _on_IsPlayerInsideArea_body_entered(body):
	if (body.is_in_group("Player")):
		actualLevel.changeCurrentPuzzlePart(self)
	if (body.is_in_group("Axis")):
		body.isOnAxis = axis

	
func move(dir):
	for ray in $RayCasts.get_children():
		ray.force_raycast_update()
		if ray.is_colliding():
			if (dir == Vector2.LEFT and ray.name == "RCLeft"
			or dir == Vector2.RIGHT and ray.name == "RCRight"
			or dir == Vector2.UP and ray.name == "RCUp"
			or dir == Vector2.DOWN and ray.name == "RCBottom"):
				return false
	return true	
	
func setWall(wallType,value):
	get_node("Clone/sides/"+wallType).visible = value
	get_node("Collision/"+wallType+"/CollisionShape2D").set_deferred("disabled",!value)
	
func setAllWalls():
	$Collision/Bottom/CollisionShape2D.set_deferred("disabled",false)
	$Collision/Top/CollisionShape2D.set_deferred("disabled",false)
	$Collision/Left/CollisionShape2D.set_deferred("disabled",false)
	$Collision/Right/CollisionShape2D.set_deferred("disabled",false)
	$Clone/sides/Bottom.visible = true
	$Clone/sides/Top.visible = true
	$Clone/sides/Left.visible = true
	$Clone/sides/Right.visible = true
	
func matchTwoDirections(dir,secondPart):
	return(
		(dir == Vector2.UP and ((topDir == directionsENUM.TRUE and secondPart.bottomDir == directionsENUM.FALSE)
			or (topDir == directionsENUM.FALSE and secondPart.bottomDir == directionsENUM.TRUE)))
			or
		(dir == Vector2.DOWN and ((bottomDir == directionsENUM.TRUE and secondPart.topDir == directionsENUM.FALSE)
			or (bottomDir == directionsENUM.FALSE and secondPart.topDir == directionsENUM.TRUE)))
			or
		(dir == Vector2.LEFT and ((leftDir == directionsENUM.TRUE and secondPart.rightDir == directionsENUM.FALSE)
			or (leftDir == directionsENUM.FALSE and secondPart.rightDir == directionsENUM.TRUE)))
			or
		(dir == Vector2.RIGHT and ((rightDir == directionsENUM.TRUE and secondPart.leftDir == directionsENUM.FALSE)
			or (rightDir == directionsENUM.FALSE and secondPart.leftDir == directionsENUM.TRUE)))
		)

func _on_IsPlayerInsideArea_area_entered(area):
	if (area.get_parent().is_in_group("Axis")):
		area.get_parent().isOnAxis = axis
