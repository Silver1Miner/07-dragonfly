extends Node

export var SCROLL_SPEED = 30

var cash = 0
var max_cash = 0
var player_hp = 50
var player_shield = 50
var player_weapon_1 = "Machine Gun 1"
var player_weapon_2 = "Empty"
var bombs = 10
var lore = [0,0,0,0,0,0,0]
var ships = [1, 0, 0]
var current_ship = 0

func _ready() -> void:
	load_data()

func load_data() -> void:
	pass

func save_data() -> void:
	pass

var crates = 0
var smg_1 = 1
var smg_2 = 0
var shotgun_1 = 0
var shotgun_2 = 0
var flamer_1 = 0
var flamer_2 = 0
var sniper_1 = 0
var sniper_2 = 0
var treasure_1 = 0
var treasure_2 = 0

var ship_visuals = [
	{	"name": "Dragonfly",
		"sprite": preload("res://assets/player/player-dragonfly.png"),
		"wings": Vector2(0,0),
		"portrait": "",
	},
	{	"name": "Scarab",
		"sprite": preload("res://assets/player/player-scarab.png"),
		"wings": Vector2(-8,0),
	},
	{	"name": "Scorpion",
		"sprite": preload("res://assets/player/player-scorpion.png"),
		"wings": Vector2(0, 0),
	},
]

var item_data = {
}
