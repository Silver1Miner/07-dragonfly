extends Control

var lore: Resource = preload("res://src/UI/lore.tres")
onready var ship_preview = $HBoxContainer/Loadout/Preview/ShipPreview
onready var lore_read = $HBoxContainer/Lore/NinePatchRect/LoreText

func _ready() -> void:
	update_hud()
	update_loadout_display()
	populate_options()

func update_hud() -> void:
	$HUD.update_hp_display(PlayerData.player_hp, 100)
	$HUD.update_sh_display(PlayerData.player_shield, 100)
	$HUD.update_en_display(100, 100)
	$HUD.update_bombs_display(PlayerData.inventory["Bombs"], 10)

func update_loadout_display() -> void:
	update_ship_choice()
	$HUD.update_loadout_display(PlayerData.player_weapon_1, PlayerData.player_weapon_2)

var available_1 = []
var available_2 = []
var available_ships = []
var ship_names = ["Dragonfly", "Scarab", "Scorpion"]
func populate_options() -> void:
	available_1.clear()
	available_2.clear()
	available_ships.clear()
	$HBoxContainer/Loadout/Primary.clear()
	$HBoxContainer/Loadout/Secondary.clear()
	$HBoxContainer/Loadout/Ship.clear()
	available_1.append("Change Slot 1")
	available_2.append("Change Slot 2")
	available_ships.append("Change Ship")
	for gun in ["Machine Gun", "Spread Gun", "Flamer", "Burner"]:
		if PlayerData.inventory[gun] > 0:
			available_1.append(gun)
	for gun2 in ["Shotgun", "Scattergun"]:
		if PlayerData.inventory[gun2] > 0:
			available_2.append(gun2)
	for i in range(3):
		if PlayerData.ships[i] > 0:
			available_ships.append(ship_names[i])
	for gun in available_1:
		$HBoxContainer/Loadout/Primary.add_item(gun)
	for gun2 in available_2:
		$HBoxContainer/Loadout/Secondary.add_item(gun2)
	for ship in available_ships:
		$HBoxContainer/Loadout/Ship.add_item(ship)

func update_ship_choice() -> void:
	ship_preview.texture = PlayerData.ship_visuals[PlayerData.current_ship]["sprite"]
	lore_read.text = lore.get_lore("ship", PlayerData.current_ship)

func _on_Ship_item_selected(index: int) -> void:
	if index == 0:
		return
	PlayerData.current_ship = index - 1
	update_ship_choice()

func _on_Primary_item_selected(index: int) -> void:
	if index == 0:
		return
	PlayerData.inventory[PlayerData.player_weapon_1] += 1
	PlayerData.inventory[available_1[index]] -= 1
	PlayerData.player_weapon_1 = available_1[index]
	populate_options()
	update_loadout_display()

func _on_Secondary_item_selected(index: int) -> void:
	if index == 0:
		return
	PlayerData.inventory[PlayerData.player_weapon_2] += 1
	PlayerData.inventory[available_2[index]] -= 1
	PlayerData.player_weapon_2 = available_2[index]
	populate_options()
	update_loadout_display()


func _on_to_mission_pressed() -> void:
	print("go to mission")

func _on_to_trading_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.trading) != OK:
		push_error("fail to change scene")
