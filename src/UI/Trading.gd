extends Control

onready var haggle = $Haggle
export var base_value = 2000

func _ready() -> void:
	if haggle.connect("offer_refused", self, "_on_offer_refused") != OK:
		push_error("signal connect fail")
	if haggle.connect("offer_made", self, "_on_offer_made") != OK:
		push_error("signal connect fail")
	haggle.base_value = base_value
	haggle.set_dial_value(base_value)

func _on_offer_refused() -> void:
	print("offer refused")

func _on_offer_made(offer_value) -> void:
	print("offer made at ", offer_value)

func _on_to_hub_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")
