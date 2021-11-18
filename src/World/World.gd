extends Node

onready var pause_menu = $Pause
var cargo_list = []
var cargo_list_string = ""

func _ready() -> void:
	connect_hud()

func connect_hud() -> void:
	if $Pause.connect("leave", self, "_on_leave") != OK:
		push_error("flee signal connect fail")
	if $Exit.connect("area_entered", self, "_on_exit_area_entered") != OK:
		push_error("exit signal connect fail")
	if $Player.connect("hp_updated", $HUD, "update_hp_display") != OK:
		push_error("hud signal connect fail")
	if $Player.connect("shield_updated", $HUD, "update_sh_display") != OK:
		push_error("hud signal connect fail")
	if $Player.connect("energy_updated", $HUD, "update_en_display") != OK:
		push_error("hud signal connect fail")
	if $Player.connect("bombs_updated", $HUD, "update_bombs_display") != OK:
		push_error("hud signal connect fail")
	if $Player.connect("loadout_updated", $HUD, "update_loadout_display") != OK:
		push_error("hud signal connect fail")
	if $Player.connect("cash_updated", $HUD, "update_cash_display") != OK:
		push_error("hud signal connect fail")
	if $Player.connect("player_destroyed", self, "_on_player_destroyed") != OK:
		push_error("player destruction signal connect fail")
	$HUD/Sections/Bottom/Glass.texture = null
	$Player.update_display()
	AudioManager.play_music("res://assets/Audio/Sky_Bandit.ogg", 0)

func _on_exit_area_entered(area) -> void:
	if area.is_in_group("player"):
		$Pause.update_cargo_list(cargo_list_string)
		$Pause.pause()

func _on_player_destroyed() -> void:
	$Pause.mission_failed()

func _on_leave() -> void:
	$Player.save_player_data()
	for cargo in cargo_list:
		if cargo in PlayerData.inventory:
			PlayerData.inventory[cargo] += 1
	ObjectRegistry.clear_screen()
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")
