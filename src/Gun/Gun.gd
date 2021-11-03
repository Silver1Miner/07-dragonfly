extends Position2D
class_name Gun

export var Bullet: PackedScene
export var cooldown := 0.5
export var direction := Vector2.UP
export var speed := 5

func _ready() -> void:
	pass

func fire() -> void:
	if not $Timer.is_stopped() or not Bullet:
		return
	print("fire")
	var bullet: Bullet = Bullet.instance()
	bullet.global_position = global_position
	bullet.direction = direction
	bullet.speed = speed
	ObjectRegistry.register_bullet(bullet)
	$Timer.wait_time = cooldown
	$Timer.start()
