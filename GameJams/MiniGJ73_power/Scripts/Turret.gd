extends Node2D

const BULLET = preload("res://Scenes/Bullet.tscn")

var haveBattery = false
var isPicked = false
var enemyToShoot = null

const SHOOT_RADIUS_SPRITE_SIZE  = 64
var isShooting = false
var timeBetweenShots = 0.6

#bulelt params
export var shootingSpeed = 130
export var bulletDamage = 4

var increasedTurretDmg = 0
var increasedTurretBulletSpeed = 1
var increaseShootingRate = 1

func _ready():
	add_to_group("TurretUpgrade")
	pass
	
func _process(delta):
	getColisions()
	showShootingRadius()	
	if (haveBattery):
		$Sprite2.visible = true
	else:
		$Sprite2.visible = false
	if (!isPicked and haveBattery):
		shoot()

func getColisions():
	haveBattery = false
	var allAreas = $BatteryRadius.get_overlapping_areas()
	for area in allAreas:
		if (area.is_in_group("BatteryRadiusToPut")):
			if(!area.get_parent().isPicked and !isPicked):
				area.get_parent().position = $BatteryPosition.global_position
				if area.get_parent().havePower(): 
					haveBattery = true
					area.get_parent().isConnected = true


func showShootingRadius():
	var scaleRadius = ($ShootRadius/CollisionShape2D.shape.radius*4)/SHOOT_RADIUS_SPRITE_SIZE
	if (isPicked):
		$ShootRadiusSprite.scale = Vector2(scaleRadius,scaleRadius)
		$ShootRadiusSprite.visible = true
	else:
		$ShootRadiusSprite.visible = false

func shoot():
	if (!isShooting): 
		getAllEnemiesInCollision()
	pass

func getAllEnemiesInCollision():
	var shortestDistance = 100000
	var closestEnemy = null
	var enemies = $ShootRadius.get_overlapping_areas()
	for area in enemies:
		if (area.is_in_group("EnemyRadius")):
			if (area.get_parent().canMove and area.get_parent().global_position.distance_to(global_position) < shortestDistance):
				shortestDistance = area.get_parent().global_position.distance_to(global_position)
				closestEnemy = area.get_parent()
	if (closestEnemy != null):
		isShooting = true
		var aimAtEnemy = (closestEnemy.global_position - global_position).normalized()
		var bullet = BULLET.instance()
		bullet.initializeParameters($ShootingPosition.global_position,atan2(aimAtEnemy.y,aimAtEnemy.x),shootingSpeed+increasedTurretBulletSpeed,bulletDamage+increasedTurretDmg)
		get_parent().get_node("Bullet").add_child(bullet)
		$ShootTimer.start(timeBetweenShots * increaseShootingRate)

func _on_ShootTimer_timeout():
	isShooting = false
	$ShootTimer.stop()
	pass # Replace with function body.
