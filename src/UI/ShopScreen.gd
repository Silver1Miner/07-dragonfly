extends NinePatchRect

signal transaction()

var item_data: Resource = preload("res://src/Data/item_data.tres")
enum shop_mode {BUY, SELL}
var current_mode = shop_mode.BUY

onready var itemlist = $Display/ItemDisplay/ItemList
onready var itemtext = $Display/ItemDisplay/ItemText
var shopping_cart = []

func _ready() -> void:
	$Display/CostDisplay.text = ""

func set_mode(mode) -> void:
	current_mode = mode
	$Display/CostDisplay.text = ""
	match current_mode:
		shop_mode.BUY:
			$Display/Label.text = "Buy from the Old Man"
			load_buy_items()
		shop_mode.SELL:
			$Display/Label.text = "Sell to the Old Man"
			load_sell_items()

var shop_inventory = [
	"Bomb","Chaingun","Spreadgun","Shotgun",
	"Scattergun","Flamer","Burner","Bolt", "Repairs"
]
func load_buy_items() -> void:
	items.clear()
	itemlist.clear()
	for item in shop_inventory:
		items.append(item)
		itemlist.add_item(item, load(item_data.get_entry(item,"icon")))

var items = []
func load_sell_items() -> void:
	items.clear()
	itemlist.clear()
	for item in PlayerData.inventory:
		if PlayerData.inventory[item] > 0:
			items.append(item)
	for item in items:
		itemlist.add_item(item + " x" + str(PlayerData.inventory[item]), load(item_data.get_entry(item,"icon")))

var current_item = ""
func _on_ItemList_item_selected(index: int) -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	current_item = items[index]
	if current_item == "Repairs":
		$Display/CostDisplay.text = "Charge to buy Repairs: 1000"
		itemtext.set_text("Get your ship patched up back up to full health.")
		return
	itemtext.set_text(item_data.get_entry(items[index], "lore"))
	match current_mode:
		shop_mode.BUY:
			$Display/CostDisplay.text = "Charge to buy " + current_item + ": " + str(item_data.data[current_item]["buy_cost"])
		shop_mode.SELL:
			$Display/CostDisplay.text = "Offer for your " + current_item + ": " + str(item_data.data[current_item]["sell_price"])

func _on_Accept_pressed() -> void:
	if current_mode == shop_mode.SELL:
		PlayerData.inventory[current_item] = clamp(PlayerData.inventory[current_item] - 1, 0, 99)
		PlayerData.cash = clamp(PlayerData.cash + item_data.data[current_item]["sell_price"], 0, PlayerData.max_cash)
		load_sell_items()
		AudioManager.play_sound("res://assets/Audio/ui/select_005.ogg")
		emit_signal("transaction")
	elif current_mode == shop_mode.BUY:
		if current_item == "Repairs":
			if PlayerData.cash >= 1000:
				PlayerData.player_hp = 100
				PlayerData.cash = clamp(PlayerData.cash - 1000, 0, PlayerData.max_cash)
				$Display/CostDisplay.text = "PURCHASED"
				emit_signal("transaction")
				AudioManager.play_sound("res://assets/Audio/ui/select_005.ogg")
			else:
				$Display/CostDisplay.text = "INSUFFICIENT FUNDS"
				AudioManager.play_sound("res://assets/Audio/ui/back_002.ogg")
		elif item_data.data[current_item]["buy_cost"] <= PlayerData.cash:
			PlayerData.inventory[current_item] = clamp(PlayerData.inventory[current_item] + 1, 0, 99)
			PlayerData.cash = clamp(PlayerData.cash - item_data.data[current_item]["buy_cost"], 0, PlayerData.max_cash)
			$Display/CostDisplay.text = "PURCHASED"
			emit_signal("transaction")
			AudioManager.play_sound("res://assets/Audio/ui/select_005.ogg")
			load_buy_items()
		else:
			$Display/CostDisplay.text = "INSUFFICIENT FUNDS"
			AudioManager.play_sound("res://assets/Audio/ui/back_002.ogg")

func _on_Decline_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/back_002.ogg")
	visible = false
