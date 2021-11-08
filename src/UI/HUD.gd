extends Control

onready var hp_text = $Sections/Top/Ship/Stats/HP/text
onready var hp_bar = $Sections/Top/Ship/Stats/HP/progressbar
onready var sh_text = $Sections/Top/Ship/Stats/SH/text
onready var sh_bar = $Sections/Top/Ship/Stats/SH/progressbar
onready var en_text = $Sections/Top/Weapons/Ammo/EN/text
onready var en_bar = $Sections/Top/Weapons/Ammo/EN/progressbar
onready var bombs_text = $Sections/Top/Weapons/Ammo/Bombs/text
onready var bombs_bar = $Sections/Top/Weapons/Ammo/Bombs/progressbar
onready var slot_1 = $Sections/Top/Loadout/Slots/Primary
onready var slot_2 = $Sections/Top/Loadout/Slots/Secondary
var started = false
var gun_stats :Resource = preload("res://src/Actors/Gun/gun_stats.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_bars()

func color_bars() -> void:
	hp_bar.set_tint_progress(Color(1,0,0))
	sh_bar.set_tint_progress(Color(0,0,1))
	en_bar.set_tint_progress(Color(0,1,0))
	bombs_bar.set_tint_progress(Color(1,1,0))

func update_hp_display(new_hp, max_hp) -> void:
	hp_text.text = "HP: " + str(round(new_hp)) + "/" + str(max_hp)
	hp_bar.max_value = max_hp
	hp_bar.value = new_hp

func update_sh_display(new_sh, max_sh) -> void:
	sh_text.text = "SH: " + str(round(new_sh)) + "/" + str(max_sh)
	sh_bar.max_value = max_sh
	sh_bar.value = new_sh

func update_en_display(new_en, max_en) -> void:
	en_text.text = "EN: " + str(round(new_en)) + "/" + str(max_en)
	en_bar.max_value = max_en
	en_bar.value = new_en

func update_bombs_display(new_bombs, max_bombs) -> void:
	bombs_text.text = "Bombs: " + str(new_bombs) + "/" + str(max_bombs)
	bombs_bar.value = 0
	if started:
		bombs_bar.get_node("Timer").start()
	else:
		started = true

func update_loadout_display(weapon_1: int, weapon_2: int) -> void:
	slot_1.text = "Slot 1: " + gun_stats.get_stats(weapon_1)["name"]
	slot_2.text = "Slot 2: " + gun_stats.get_stats(weapon_2)["name"]

func _process(_delta) -> void:
	bombs_bar.value = 100 - bombs_bar.get_node("Timer").time_left * 100
