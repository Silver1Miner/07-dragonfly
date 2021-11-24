extends HBoxContainer

var item_data: Resource = preload("res://src/Data/item_data.tres")

onready var itemlist = $ItemList
onready var itemtext = $ItemText
var items = []

func _ready() -> void:
	load_items()

func load_items() -> void:
	for item in PlayerData.inventory:
		if PlayerData.inventory[item] > 0:
			items.append(item)
	for item in items:
		itemlist.add_item(item + " x" + str(PlayerData.inventory[item]),load(item_data.get_entry(item,"icon")))

func _on_ItemList_item_selected(index: int) -> void:
	if index < len(items):
		print(items[index])
		itemtext.set_text(item_data.get_entry(items[index], "lore"))
