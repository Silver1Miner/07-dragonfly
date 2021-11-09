extends Control

var lore: Resource = preload("res://src/UI/lore.tres")
onready var ship_preview = $HBoxContainer/Loadout/Preview/ShipPreview
onready var lore_read = $HBoxContainer/Lore/NinePatchRect/RichTextLabel

func _ready() -> void:
	update_hud()
	update_loadout_display()

func update_hud() -> void:
	$HUD.update_hp_display(PlayerData.player_hp, 100)
	$HUD.update_sh_display(PlayerData.player_shield, 100)
	$HUD.update_en_display(100, 100)
	$HUD.update_bombs_display(PlayerData.bombs, 10)

func update_loadout_display() -> void:
	update_ship_choice()
	$HUD.update_loadout_display(PlayerData.player_weapon_1, PlayerData.player_weapon_2)

func update_ship_display() -> void:
	pass

func update_ship_choice() -> void:
	ship_preview.texture = PlayerData.ship_visuals[PlayerData.current_ship]["sprite"]
	lore_read.text = lore.get_lore("ship", PlayerData.current_ship)

func _on_Ship_item_selected(index: int) -> void:
	print(index)


func _on_Primary_item_selected(index: int) -> void:
	print(index)


func _on_Secondary_item_selected(index: int) -> void:
	print(index)
