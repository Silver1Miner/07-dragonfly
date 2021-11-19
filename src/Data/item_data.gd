extends Resource

func get_entry(name: String, entry: String) -> String:
	if name in data:
		return data[name][entry]
	return "entry not found"

func has(item: String) -> bool:
	return item in data

func get_stats(type: String) -> Dictionary:
	if type in data:
		return data[type]
	return {}

var data = {
	"Dragonfly": {
			"lore": """The Dragonfly Class airship"""},
	"Scarab": {
		"lore": """The Scarab Class airship"""},
	"Scorpion": {
		"lore": """The Scorpion Class airship"""},
	"Bombs": {
		"lore": """Bombs pack a lot of punch, but can only be dropped. Gravity has to take care of the rest. I hope you paid attention to your physics classes!""",
		"baseprice": 1000,
	},
	"Chaingun": {
		"lore": """The Chain Gun""",
		"baseprice": 1000,
		"damage": 2.0,
		"cooldown": 0.2,
		"direction": Vector2.RIGHT,
		"speed": 300,
		"lifetime": 3.0,
		"energy_cost": 10.0,
		"target_groups": ["enemy"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 1,
		"angle": 0,
		"bullet": preload("res://src/Actors/Gun/Bullet.tscn")
	},
	"Spreadgun": {
		"lore": """The Spreadgun spreads the love out""",
		"baseprice": 1000,
		"damage": 1.0,
		"cooldown": 0.2,
		"direction": Vector2.RIGHT,
		"speed": 300,
		"lifetime": 3.0,
		"energy_cost": 10.0,
		"target_groups": ["enemy"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 2,
		"angle": 5,
		"bullet": preload("res://src/Actors/Gun/Bullet.tscn")
	},
	"Shotgun": {
		"lore": """The shotgun packs a punch at close range""",
		"baseprice": 1000,
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
	"Scattergun": {
		"lore": """The scattergun spreads the love.""",
		"baseprice": 1000,
		"damage": 5.0,
		"cooldown": 0.9,
		"direction": Vector2.RIGHT,
		"speed": 600,
		"lifetime": 0.3,
		"energy_cost": 35.0,
		"target_groups": ["enemy"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 3,
		"angle": 12,
		"bullet": preload("res://src/Actors/Gun/Bullet.tscn")
	},
	"Flamer": {
		"lore": """The flamer flames""",
		"baseprice": 1000,
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
	"Burner": {
		"lore": """The burner blasts""",
		"baseprice": 1000,
		"damage": 1.0,
		"cooldown": 0.1,
		"direction": Vector2.RIGHT,
		"speed": 800,
		"lifetime": 0.2,
		"energy_cost": 10.0,
		"target_groups": ["enemy"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 2,
		"angle": 2,
		"bullet": preload("res://src/Actors/Gun/Bullet_Flame.tscn")
	},
	"Bolt": {
		"lore": """The Bolt Beam""",
		"baseprice": 1000,
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
	"Enemy Chain Gun": {
		"lore": "A cheap gun often used by private security forces",
		"baseprice": 0,
		"damage": 20.0,
		"cooldown": 1.0,
		"direction": Vector2.LEFT,
		"speed": 50,
		"lifetime": 15.0,
		"energy_cost": 0,
		"target_groups": ["player"],
		"bullet_groups": ["enemy_bullet"],
		"bullet_number": 1,
		"angle": 15,
		"bullet": preload("res://src/Actors/Gun/Bullet_Enemy.tscn")
	},
	"Enemy Turret Gun": {
		"lore": "A cheap gun often used by private security forces",
		"baseprice": 0,
		"damage": 20.0,
		"cooldown": 3.0,
		"direction": Vector2.LEFT,
		"speed": 40,
		"lifetime": 20.0,
		"energy_cost": 0,
		"target_groups": ["player"],
		"bullet_groups": ["enemy_bullet"],
		"bullet_number": 1,
		"angle": 15,
		"bullet": preload("res://src/Actors/Gun/Bullet_Enemy_turret.tscn")
	}
}
