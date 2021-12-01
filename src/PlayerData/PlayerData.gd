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
var lore_found = 0 # max 4
var ships = [1, 1, 1]
var current_ship = 0
var current_chat_scene = -1
var new_game = false
var end_game = false
var tutorial = true

var current_slot := 0
var current_save = {
	"cash": 100,
	"player_hp": 100,
	"player_shield": 100,
	"player_weapon_1": "Chaingun",
	"player_weapon_2": "Shotgun",
	"lore_found": 0,
	"current_ship": 0,
	"current_chat_scene": -1,
	"inventory": {
		"Crate": 0,
		"Bomb": 10,
		"Chaingun": 0,
		"Spreadgun": 0,
		"Shotgun": 0,
		"Scattergun": 0,
		"Flamer": 0,
		"Burner": 0,
		"Bolt": 0,
		"Raw Spiderweb Silk": 0,
		"Gold Bugs": 0,
		"Silverfish Coins": 0,
		"Chitin Shell": 0,
		"Spiderweb Silk Shirt": 0,
		"Water": 0,
		"Watermelon": 0
	}
}
var default_save = {
	"cash": 100,
	"player_hp": 100,
	"player_shield": 100,
	"player_weapon_1": "Chaingun",
	"player_weapon_2": "Shotgun",
	"lore_found": 0,
	"current_ship": 0,
	"current_chat_scene": -1,
	"inventory": {
		"Crate": 0,
		"Bomb": 10,
		"Chaingun": 0,
		"Spreadgun": 0,
		"Shotgun": 0,
		"Scattergun": 0,
		"Flamer": 0,
		"Burner": 0,
		"Bolt": 0,
		"Raw Spiderweb Silk": 0,
		"Gold Bugs": 0,
		"Silverfish Coins": 0,
		"Chitin Shell": 0,
		"Spiderweb Silk Shirt": 0,
		"Water": 0,
		"Watermelon": 0
	}
}

func _ready() -> void:
	pass
	#current_save = load_game(current_slot)
	#load_data(current_save)

func load_data(data: Dictionary) -> void:
	cash = data["cash"]
	player_hp = data["player_hp"]
	player_shield = data["player_shield"]
	player_weapon_1 = data["player_weapon_1"]
	player_weapon_2 = data["player_weapon_2"]
	lore_found = data["lore_found"]
	current_ship = data["current_ship"]
	current_chat_scene = data["current_chat_scene"]
	inventory = data["inventory"]

func save_data() -> void:
	current_save["cash"] = cash
	current_save["player_hp"] = player_hp
	current_save["player_shield"] = player_shield
	current_save["player_weapon_1"] = player_weapon_1
	current_save["player_weapon_2"] = player_weapon_2
	current_save["lore_found"] = lore_found
	current_save["current_ship"] = current_ship
	current_save["current_chat_scene"] = current_chat_scene
	current_save["inventory"] = inventory

func get_save_date(slot) -> String:
	var F = File.new() #
	var D = Directory.new() 
	if D.dir_exists("user://save"):
		if F.open(str("user://save/",slot,".save"), File.READ_WRITE) == OK:
			var time = OS.get_datetime_from_unix_time(F.get_modified_time(str("user://save/",slot,".save")))
			return str(time["year"])+"/"+str(time["month"])+"/"+str(time["day"])+" "+str(time["hour"])+":"+str(time["minute"])+":"+str(time["second"])
		else:
			return "no save in slot"
	else:
		return "no save in slot"

func load_game(slot) -> Dictionary:
	print("loaded game ", str(slot))
	var F = File.new() #
	var D = Directory.new() 
	if D.dir_exists("user://save"):
		if F.open(str("user://save/",slot,".save"), File.READ_WRITE) == OK:
			var temp_d = F.get_var()
			print(temp_d)
			print(F.get_modified_time(str("user://save/",slot,".save")))
			return temp_d
		else:
			print("save file doesn't exist, creating one") 
			save_game(slot) 
			return default_save
	else:
		print("directory doesn't exist, creating one")
		D.make_dir("user://save")
		save_game(slot)
		return default_save

func save_game(slot) -> void:
	print("save data ", str(slot))
	save_data()
	print(current_save)
	var F = File.new()
	F.open(str("user://save/",slot,".save"), File.WRITE)
	F.store_var(current_save)
	print(F.get_modified_time(str("user://save/",slot,".save")))
	F.close()

var inventory = {
	"Crate": 0,
	"Bomb": 10,
	"Chaingun": 0,
	"Spreadgun": 0,
	"Shotgun": 0,
	"Scattergun": 0,
	"Flamer": 0,
	"Burner": 0,
	"Bolt": 0,
	"Raw Spiderweb Silk": 0,
	"Gold Bugs": 0,
	"Silverfish Coins": 0,
	"Chitin Shell": 0,
	"Spiderweb Silk Shirt": 0,
	"Water": 0,
	"Watermelon": 0
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
