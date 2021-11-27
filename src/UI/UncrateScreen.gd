extends NinePatchRect

signal transaction()
var item_data: Resource = preload("res://src/Data/item_data.tres")

onready var uncrate_button = $Display/Accept
onready var decline_button = $Display/Decline
onready var result_button = $Result/ResultDisplay/ResultClose
onready var result_panel = $Result
onready var crate_animation = $Display/CrateDisplay/CenterContainer/AnimatedSprite
onready var crate_number = $Display/CrateDisplay/CrateNumber
onready var result_label = $Result/ResultDisplay/ResultLabel
onready var result_icon = $Result/ResultDisplay/CenterContainer/ResultIcon

func _ready() -> void:
	uncrate_button.disabled = (PlayerData.inventory["Crate"] <= 0 or PlayerData.cash < 60)
	update_crate_number(PlayerData.inventory["Crate"])
	crate_animation.frame = 0
	result_panel.visible = false

func refresh() -> void:
	uncrate_button.disabled = (PlayerData.inventory["Crate"] <= 0 or PlayerData.cash < 60)
	crate_animation.visible = (PlayerData.inventory["Crate"] > 0)

func update_crate_number(new_number) -> void:
	crate_number.text = "Crates Remaining: " + str(new_number)

func _on_Accept_pressed() -> void:
	uncrate_button.disabled = true
	decline_button.disabled = true
	AudioManager.play_sound("res://assets/Audio/ui/doorOpen_2.ogg")
	crate_animation.play("open")
	roll()

func _on_Decline_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/back_002.ogg")
	visible = false

func _on_ResultClose_pressed() -> void:
	refresh()
	crate_animation.frame = 0
	crate_animation.playing = false
	result_panel.visible = false
	uncrate_button.disabled = (PlayerData.inventory["Crate"] <= 0 or PlayerData.cash < 60)
	decline_button.disabled = false

func _on_AnimatedSprite_animation_finished() -> void:
	emit_signal("transaction")
	result_panel.visible = true

func roll() -> void:
	PlayerData.inventory["Crate"] = clamp(PlayerData.inventory["Crate"]-1, 0, 99)
	PlayerData.cash = clamp(PlayerData.cash - 60, 0, PlayerData.max_cash)
	update_crate_number(PlayerData.inventory["Crate"])
	randomize()
	var roll = rand_range(0, 99)
	if roll < 1:
		get_prize("Gold Bugs")
	elif roll >= 1 and roll < 5:
		get_prize("Raw Spiderweb Silk")
	elif roll >= 5 and roll < 10:
		get_prize("Silverfish Coins")
	elif roll >= 10 and roll < 20:
		get_prize("Chitin Shell")
	elif roll >= 20 and roll < 30:
		get_prize("Spiderweb Silk Shirt")
	elif roll >= 30 and roll < 50:
		get_prize("Water")
	elif roll >= 50 and roll < 70:
		get_prize("Watermelon")
	else:
		get_prize("Bomb")

func get_prize(prize_name) -> void:
	if prize_name in item_data.data:
		if prize_name in PlayerData.inventory:
			PlayerData.inventory[prize_name] = clamp(PlayerData.inventory[prize_name]+1,0,99)
			result_label.text = "Found " + prize_name
			result_icon.texture = load(item_data.data[prize_name]["icon"])
