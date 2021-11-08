extends Position2D
class_name Gun

export var Bullet: PackedScene = preload("res://src/Actors/Gun/Bullet.tscn")
export var gun_stats: Resource = preload("res://src/Actors/Gun/gun_stats.tres")
export var damage :float = 2.0
export var cooldown :float = 0.2
export var direction :Vector2 = Vector2.RIGHT
export var speed :float = 300
export var lifetime :float = 2.0
export var energy_cost :float = 10.0
export var bullet_number :int = 1
export var angle :float = 10.0
var target_groups = ["enemy"]
var bullet_groups = ["player_bullet"]

func load_gun_data(gun_type) -> void:
	var stats = gun_stats.get_stats(gun_type)
	damage = stats["damage"]
	cooldown = stats["cooldown"]
	direction = stats["direction"]
	speed = stats["speed"]
	lifetime = stats["lifetime"]
	energy_cost = stats["energy_cost"]
	bullet_number = stats["bullet_number"]
	target_groups = stats["target_groups"]
	bullet_groups = stats["bullet_groups"]
	angle = stats["angle"]
	Bullet = stats["bullet"]

func get_energy_cost() -> float:
	return energy_cost

func fire() -> void:
	if not $Timer.is_stopped() or not Bullet:
		return
	for n in range(bullet_number):
		var bullet: Bullet = Bullet.instance()
		fire_bullet(bullet, n)
		if n > 0:
			var bullet2: Bullet = Bullet.instance()
			fire_bullet(bullet2, -n)
	$Timer.wait_time = cooldown
	$Timer.start()

func fire_bullet(bullet: Bullet, n: int) -> void:
	for group in bullet_groups:
		bullet.add_to_group(group)
	bullet.target_groups = target_groups
	bullet.damage = damage
	bullet.global_position = global_position
	bullet.direction = direction.rotated(n * deg2rad(angle))
	bullet.speed = speed
	bullet.lifetime = lifetime
	bullet.global_rotation_degrees = n * angle
	ObjectRegistry.register_bullet(bullet)
