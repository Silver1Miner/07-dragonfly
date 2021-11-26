extends Node

export var SCROLL_SPEED = 30
var text_scroll: PackedScene = preload("res://src/UI/TextScroll.tscn")
var main_menu: PackedScene = preload("res://src/Menu/MainMenu.tscn")
var hub: PackedScene = preload("res://src/UI/Hub.tscn")
var trading: PackedScene = preload("res://src/UI/Trading.tscn")
var mission: PackedScene = preload("res://src/World/World.tscn")

var current_position = Vector2.ZERO
var cash = 6000
var max_cash = 999999
var player_hp = 50
var player_shield = 100
var player_weapon_1 = "Spreadgun"
var player_weapon_2 = "Bolt"
var lore_found = 4 # max 4
var ships = [1, 1, 1]
var current_ship = 0
var current_chat_scene = -1
var new_game = false

func _ready() -> void:
	pass

func load_data() -> void:
	print("loaded game")

func save_data() -> void:
	pass

var inventory = {
	"Crate": 10,
	"Bomb": 10,
	"Chaingun": 1,
	"Spreadgun": 1,
	"Shotgun": 1,
	"Scattergun": 1,
	"Flamer": 1,
	"Burner": 1,
	"Bolt": 1,
	"Spiderweb Silk": 1,
	"Gold Bugs": 1,
}

var ship_visuals = [
	{	"name": "Dragonfly",
		"sprite": preload("res://assets/player/player-dragonfly.png"),
		"wings": Vector2(0,0),
		"Gun2": Vector2(16,5),
	},
	{	"name": "Scarab",
		"sprite": preload("res://assets/player/player-scarab.png"),
		"wings": Vector2(-8,0),
		"Gun2": Vector2(16,-4),
	},
	{	"name": "Scorpion",
		"sprite": preload("res://assets/player/player-scorpion.png"),
		"wings": Vector2(0, 0),
		"Gun2": Vector2(12,-6),
	},
]
