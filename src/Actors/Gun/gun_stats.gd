class_name Gun_Stats
extends Resource

func get_stats(type: String) -> Dictionary:
	return stats[type]

func has(type: String) -> bool:
	return (type in stats)

var stats := {
	"Machine Gun": {
		"damage": 2.0,
		"cooldown": 0.2,
		"direction": Vector2.RIGHT,
		"speed": 300,
		"lifetime": 2.0,
		"energy_cost": 10.0,
		"target_groups": ["enemy"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 1,
		"angle": 0,
		"bullet": preload("res://src/Actors/Gun/Bullet.tscn")
	},
	"Shotgun": {
		"damage": 4.0,
		"cooldown": 0.8,
		"direction": Vector2.RIGHT,
		"speed": 600,
		"lifetime": 0.4,
		"energy_cost": 30.0,
		"target_groups": ["enemy"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 2,
		"angle": 15,
		"bullet": preload("res://src/Actors/Gun/Bullet.tscn")
	},
	"Flamer": {
		"damage": 1.0,
		"cooldown": 0.1,
		"direction": Vector2.RIGHT,
		"speed": 600,
		"lifetime": 0.4,
		"energy_cost": 10.0,
		"target_groups": ["enemy"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 3,
		"angle": 5,
		"bullet": preload("res://src/Actors/Gun/Bullet_Flame.tscn")
	},
	"Bolt": {
		"damage": 100.0,
		"cooldown": 1.0,
		"direction": Vector2.RIGHT,
		"speed": 0,
		"lifetime": 0.5,
		"energy_cost": 80.0,
		"target_groups": ["enemy"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 1,
		"angle": 15,
		"bullet": preload("res://src/Actors/Gun/Bullet_Bolt.tscn")
	},
}
