extends NinePatchRect


var item_data: Resource = preload("res://src/Data/item_data.tres")
enum shop_mode {BUY, SELL}
var current_mode = shop_mode.BUY

onready var itemlist = $Display/ItemDisplay/ItemList
onready var itemtext = $Display/ItemDisplay/Right/ItemText
onready var shoppingcart = $Display/ItemDisplay/Right/ShoppingCart
var shopping_cart = []

func _ready() -> void:
	pass

func set_mode(mode) -> void:
	match mode:
		shop_mode.BUY:
			$Display/Label.text = "Buy from the Old Man"
		shop_mode.SELL:
			$Display/Label.text = "Sell to the Old Man"

func load_buy_items() -> void:
	pass

func load_sell_items() -> void:
	pass

func _on_ShoppingCart_item_activated(_index: int) -> void:
	pass # Replace with function body.

func _on_ItemList_item_activated(_index: int) -> void:
	pass # Replace with function body.
