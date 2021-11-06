extends Node

export var SCROLL_SPEED = 30

var player_hp = 100
var player_shield = 100

var lore = [0,0,0,0,0,0,0]

var bombs = 10
var crates = 0
var shotgun_1 = 0
var shotgun_2 = 0
var shotgun_3 = 0
var smg_1 = 0
var smg_2 = 0
var smg_3 = 0
var flamer_1 = 0
var flamer_2 = 0
var flamer_3 = 0
var sniper_1 = 0
var sniper_2 = 0
var sniper_3 = 0

func _ready() -> void:
	load_data()

func load_data() -> void:
	pass

func save_data() -> void:
	pass
