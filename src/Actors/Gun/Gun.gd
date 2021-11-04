extends Position2D
class_name Gun

export var Bullet: PackedScene
export var cooldown := 0.2
export var direction := Vector2.UP
export var speed := 200
export var lifetime := 2

func _ready() -> void:
	pass

func fire() -> void:
	if not $Timer.is_stopped() or not Bullet:
		return
	var bullet: Bullet = Bullet.instance()
	bullet.global_position = global_position
	bullet.direction = direction
	bullet.speed = speed
	bullet.lifetime = lifetime
	ObjectRegistry.register_bullet(bullet)
	$Timer.wait_time = cooldown
	$Timer.start()
