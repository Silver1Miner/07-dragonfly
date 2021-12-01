extends Node

onready var pause_menu = $Pause
onready var player = $Player
var cargo_list = []
var cargo_list_string = ""
#var crates_gained = 0
var train2 = preload("res://src/Actors/Enemy/Train2.tscn")
var train3 = preload("res://src/Actors/Enemy/Train3.tscn")
var train4 = preload("res://src/Actors/Enemy/Train4.tscn")

func _ready() -> void:
	if PlayerData.tutorial:
		PlayerData.tutorial = false
	else:
		choose_train()
	connect_hud()

func choose_train() -> void:
	randomize()
	var r = rand_range(0,3)
	if r < 1:
		for n in $Enemy.get_children():
			$Enemy.remove_child(n)
			n.queue_free()
		$Enemy.add_child(train2.instance())
	elif r >=1 and r < 2:
		for n in $Enemy.get_children():
			$Enemy.remove_child(n)
			n.queue_free()
		$Enemy.add_child(train3.instance())
	else:
		for n in $Enemy.get_children():
			$Enemy.remove_child(n)
			n.queue_free()
		$Enemy.add_child(train4.instance())

func connect_hud() -> void:
	if $Pause.connect("leave", self, "_on_leave") != OK:
		push_error("flee signal connect fail")
	if $Exit.connect("area_entered", self, "_on_exit_area_entered") != OK:
		push_error("exit signal connect fail")
	if $Exit_End.connect("area_entered", self, "_on_end_area_entered") != OK:
		push_error("exit signal connect fail")
	if player.connect("hp_updated", $HUD, "update_hp_display") != OK:
		push_error("hud signal connect fail")
	if player.connect("shield_updated", $HUD, "update_sh_display") != OK:
		push_error("hud signal connect fail")
	if player.connect("energy_updated", $HUD, "update_en_display") != OK:
		push_error("hud signal connect fail")
	if player.connect("bombs_updated", $HUD, "update_bombs_display") != OK:
		push_error("hud signal connect fail")
	if player.connect("loadout_updated", $HUD, "update_loadout_display") != OK:
		push_error("hud signal connect fail")
	if player.connect("cash_updated", $HUD, "update_cash_display") != OK:
		push_error("hud signal connect fail")
	if player.connect("player_destroyed", self, "_on_player_destroyed") != OK:
		push_error("player destruction signal connect fail")
	player.update_display()
	AudioManager.play_music("res://assets/Audio/Sky_Bandit.ogg", 24.8)

func _on_exit_area_entered(area) -> void:
	if area.is_in_group("player"):
		#crates_gained = player.crates_gained
		#cargo_list_string = str(cargo_list)
		$Pause.update_cargo_list("Crates x" + str(pause_menu.crates_gained))
		$Pause.pause()

func _on_end_area_entered(area) -> void:
	if area.is_in_group("player"):
		pause_menu.crates_gained = player.crates_gained
		$Pause.update_cargo_list("Crates x" + str(pause_menu.crates_gained))
		$Pause.end_mission()

func _on_player_destroyed() -> void:
	$Pause.mission_failed()

func _on_leave() -> void:
	$Player.save_player_data()
	PlayerData.inventory["Crate"] += pause_menu.crates_gained
	#for cargo in cargo_list:
	#	if cargo in PlayerData.inventory:
	#		PlayerData.inventory[cargo] += 1
	ObjectRegistry.clear_screen()
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")
