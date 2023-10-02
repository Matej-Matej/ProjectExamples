extends Node2D

var velocity = Vector2()
var bulletDamage = 1

func _ready():
	$Sprite.play("default")

func initializeParameters(pPosition,pRotation,attackSpeed,attackDamage):
	global_position = pPosition
	rotation = pRotation
	bulletDamage = attackDamage
	velocity = Vector2(attackSpeed,0).rotated(rotation)

func _process(delta):
	position += velocity * delta


func _on_BulletArea_area_entered(area):
	if (area.is_in_group("EnemyRadius")):
		area.get_parent().dealDamage(bulletDamage)
		queue_free()
