extends Control

onready var cash_text = $Sections/Top/Money/Stats/Cash
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
onready var profile_pic = $Sections/Bottom/Panel/Profile

func _ready() -> void:
	color_bars()

func color_bars() -> void:
	hp_bar.set_tint_progress(Color(172.0/255,57.0/255,57.0/255))
	sh_bar.set_tint_progress(Color(54.0/255,187.0/255,245.0/255))
	en_bar.set_tint_progress(Color(113.0/255,137.0/255,55.0/255))
	bombs_bar.set_tint_progress(Color(1,204.0/255,0))

var current_profile = "ava-base"
var profiles = {
	"ava-base": preload("res://assets/avatars/ava-base.png"),
	"ava-hurt": preload("res://assets/avatars/ava-hurt.png"),
	"ava-upset": preload("res://assets/avatars/ava-upset.png"),
	"ava-excited": preload("res://assets/avatars/ava-excited.png")
}
func change_avatar(avatar_name) -> void:
	$Sections/Bottom/Panel/Profile.set_texture(profiles[avatar_name])

func update_cash_display(new_cash) -> void:
	cash_text.text = str(new_cash) + " "
	profile_pic.texture = profiles["ava-excited"]
	$Timer.wait_time = 0.8
	$Timer.start()

func update_hp_display(new_hp, old_hp, max_hp) -> void:
	if new_hp <= 0:
		profile_pic.self_modulate = Color(0,0,0)
		$Sections/Bottom/Panel/Back.self_modulate = Color(0,0,0)
	elif new_hp < 20:
		current_profile = "ava-upset"
	else:
		current_profile = "ava-base"
	if new_hp < old_hp:
		profile_pic.texture = profiles["ava-hurt"]
		$Timer.wait_time = 0.8
		$Timer.start()
	hp_text.text = str(round(new_hp)) + " "
	hp_bar.max_value = max_hp
	hp_bar.value = new_hp

func update_sh_display(new_sh, max_sh) -> void:
	sh_text.text = str(round(new_sh)) + " "
	sh_bar.max_value = max_sh
	sh_bar.value = new_sh

func update_en_display(new_en, max_en) -> void:
	en_text.text = str(round(new_en)) + " "
	en_bar.max_value = max_en
	en_bar.value = new_en

func update_bombs_display(new_bombs, _max_bombs) -> void:
	bombs_text.text = str(new_bombs) + " "
	bombs_bar.value = 0
	if started:
		bombs_bar.get_node("Timer").start()
	else:
		started = true

func update_loadout_display(weapon_1: String, weapon_2: String) -> void:
	slot_1.text = "Slot 1: " + weapon_1
	slot_2.text = "Slot 2: " + weapon_2

func _process(_delta) -> void:
	bombs_bar.value = 100 - bombs_bar.get_node("Timer").time_left * 100

func _on_Timer_timeout() -> void:
	profile_pic.texture = profiles[current_profile]
