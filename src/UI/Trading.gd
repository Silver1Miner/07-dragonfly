extends Control

var item_data: Resource = preload("res://src/Data/item_data.tres")
var current_item: String = "Shotgun"

func _ready() -> void:
	if $Shop.connect("transaction", self, "_on_transaction") != OK:
		push_error("shop signal connect fail")
	$Shop.visible = false
	$HUD.change_avatar("ava-upset")
	$HUD.update_hp_display(PlayerData.player_hp, PlayerData.player_hp, 100)
	$HUD.update_sh_display(PlayerData.player_shield, 100)
	$HUD.update_en_display(100, 100)
	$HUD.update_bombs_display(PlayerData.inventory["Bomb"], 10)
	$HUD.update_cash_display(PlayerData.cash)

func _on_transaction() -> void:
	$HUD.update_hp_display(PlayerData.player_hp, PlayerData.player_hp, 100)
	$HUD.update_cash_display(PlayerData.cash)

func _on_to_hub_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")

func _on_buy_pressed() -> void:
	$Shop.set_mode(0) # BUY 0
	$Shop.visible = true
	print("enter buy screen")

func _on_sell_pressed() -> void:
	$Shop.set_mode(1) # SELL 1
	$Shop.visible = true
	print("enter buy screen")

func _on_crate_pressed() -> void:
	$Shop.visible = false
	print("enter crate open screen")
