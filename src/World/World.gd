extends Node

func _ready() -> void:
	connect_hud()

func connect_hud() -> void:
	if $Player.connect("hp_updated", $HUD, "update_hp_display") != OK:
		push_error("hud signal connect fail")
	if $Player.connect("shield_updated", $HUD, "update_sh_display") != OK:
		push_error("hud signal connect fail")
	if $Player.connect("energy_updated", $HUD, "update_en_display") != OK:
		push_error("hud signal connect fail")
	if $Player.connect("bombs_updated", $HUD, "update_bombs_display") != OK:
		push_error("hud signal connect fail")
	$Player.update_display()
