extends Control

var item_data: Resource = preload("res://src/Data/item_data.tres")
var current_item: String = "Shotgun"

func _ready() -> void:
	$Shop.visible = false

func _on_to_hub_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")

func _on_buy_pressed() -> void:
	$Shop.set_mode(0)
	$Shop.visible = true
	print("enter buy screen")

func _on_sell_pressed() -> void:
	$Shop.set_mode(1)
	$Shop.visible = true
	print("enter buy screen")

func _on_crate_pressed() -> void:
	$Shop.visible = false
	print("enter crate open screen")
