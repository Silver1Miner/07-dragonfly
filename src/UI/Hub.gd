extends Control

var item_data: Resource = preload("res://src/Data/item_data.tres")
onready var ship_preview = $HBoxContainer/Loadout/Preview/ShipPreview
onready var lore_read = $HBoxContainer/Lore/NinePatchRect/LoreText
onready var textbox = $HUD/Textbox
onready var lore_selector = $HBoxContainer/Lore/Options/Data

func _ready() -> void:
	if textbox.connect("text_finished", self, "_on_text_finished") != OK:
		push_error("textbox signal connect fail")
	update_hud()
	update_loadout_display()
	populate_options()
	populate_lore_data()
	if PlayerData.new_game:
		textbox.play_dialogue(textbox.new_game_text)
		$Choices.visible = false
		PlayerData.new_game = false
	$HUD.change_avatar("ava-base")

func update_hud() -> void:
	$HUD.update_hp_display(PlayerData.player_hp, PlayerData.player_hp, 100)
	$HUD.update_sh_display(PlayerData.player_shield, 100)
	$HUD.update_en_display(100, 100)
	$HUD.update_bombs_display(PlayerData.inventory["Bomb"], 99)
	$HUD.update_cash_display(PlayerData.cash)

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
	for gun in ["Chaingun", "Spreadgun", "Flamer", "Burner"]:
		if PlayerData.inventory[gun] > 0:
			available_1.append(gun)
	for gun2 in ["Shotgun", "Scattergun", "Bolt"]:
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
	$HBoxContainer/Lore/Options/Inventory.pressed = false
	ship_preview.texture = PlayerData.ship_visuals[PlayerData.current_ship]["sprite"]
	lore_read.text = item_data.get_entry(ship_names[PlayerData.current_ship], "lore")

func _on_Ship_item_selected(index: int) -> void:
	AudioManager.play_sound("res://assets/Audio/select_005.ogg")
	if index == 0:
		return
	PlayerData.current_ship = index - 1
	update_ship_choice()

func _on_Primary_item_selected(index: int) -> void:
	AudioManager.play_sound("res://assets/Audio/select_005.ogg")
	if index == 0:
		return
	PlayerData.inventory[PlayerData.player_weapon_1] += 1
	PlayerData.inventory[available_1[index]] -= 1
	PlayerData.player_weapon_1 = available_1[index]
	populate_options()
	update_loadout_display()
	lore_read.set_text(item_data.get_entry(PlayerData.player_weapon_1, "lore"))

func _on_Secondary_item_selected(index: int) -> void:
	AudioManager.play_sound("res://assets/Audio/select_005.ogg")
	if index == 0:
		return
	PlayerData.inventory[PlayerData.player_weapon_2] += 1
	PlayerData.inventory[available_2[index]] -= 1
	PlayerData.player_weapon_2 = available_2[index]
	populate_options()
	update_loadout_display()
	lore_read.set_text(item_data.get_entry(PlayerData.player_weapon_2, "lore"))

func _on_to_mission_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	if get_tree().change_scene_to(PlayerData.mission) != OK:
		push_error("fail to start mission")

func _on_to_trading_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	if get_tree().change_scene_to(PlayerData.trading) != OK:
		push_error("fail to change scene")

func _on_chat_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	if PlayerData.current_chat_scene < 5:
		PlayerData.current_chat_scene += 1
	else:
		PlayerData.current_chat_scene = 0
	textbox.play_dialogue(textbox.chat_scenes[PlayerData.current_chat_scene])
	$Choices.visible = false

func _on_text_finished() -> void:
	$Choices.visible = true

func _on_to_saves_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	print("saves pressed")

func _on_Inventory_toggled(button_pressed: bool) -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	$HBoxContainer/Lore/NinePatchRect/InventoryInfo.visible = button_pressed
	$HBoxContainer/Lore/NinePatchRect/LoreText.visible = !button_pressed

func populate_lore_data() -> void:
	lore_selector.clear()
	lore_selector.add_item("DATA")
	for index in PlayerData.lore_found:
		lore_selector.add_item(item_data.lore[index]["name"])

func _on_Data_item_selected(index: int) -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	$HBoxContainer/Lore/Options/Inventory.pressed = false
	if index > 0:
		lore_read.set_text(item_data.get_lore(index-1))
