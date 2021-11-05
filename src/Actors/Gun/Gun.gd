extends Position2D
class_name Gun

export var Bullet: PackedScene
export var damage := 2.0
export var cooldown := 0.2
export var direction := Vector2.UP
export var speed := 200
export var lifetime := 2
export var energy_cost := 10.0
var target_groups = ["enemy"]

func _ready() -> void:
	pass

func get_energy_cost() -> float:
	return energy_cost

func fire() -> void:
	if not $Timer.is_stopped() or not Bullet:
		return
	var bullet: Bullet = Bullet.instance()
	for group in get_groups():
		bullet.add_to_group(group)
	bullet.target_groups = target_groups
	bullet.damage = damage
	bullet.global_position = global_position
	bullet.direction = direction
	bullet.speed = speed
	bullet.lifetime = lifetime
	ObjectRegistry.register_bullet(bullet)
	$Timer.wait_time = cooldown
	$Timer.start()
