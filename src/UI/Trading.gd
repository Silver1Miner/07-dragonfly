extends Control

onready var haggle = $Haggle
var item_data: Resource = preload("res://src/Data/item_data.tres")
var current_item: String = "Shotgun"

func _ready() -> void:
	if haggle.connect("offer_refused", self, "_on_offer_refused") != OK:
		push_error("signal connect fail")
	if haggle.connect("offer_made", self, "_on_offer_made") != OK:
		push_error("signal connect fail")
	haggle.set_target_item(current_item)
	haggle.base_value = item_data.get_entry(current_item, "baseprice")
	haggle.set_dial_value(haggle.base_value)

func _on_offer_refused() -> void:
	print("offer refused")

func _on_offer_made(offer_value) -> void:
	print("offer made at ", offer_value)

func _on_to_hub_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")
