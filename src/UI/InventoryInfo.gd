extends HBoxContainer

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
		itemlist.add_item(item + " x" + str(PlayerData.inventory[item]))

func _on_ItemList_item_selected(index: int) -> void:
	if index < len(items):
		print(items[index])
