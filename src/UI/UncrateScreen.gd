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
onready var result_icon = $Result/ResultDisplay/ResultIcon

func _ready() -> void:
	uncrate_button.disabled = (PlayerData.inventory["Crate"] <= 0 or PlayerData.cash < 60)
	update_crate_number(PlayerData.inventory["Crate"])
	crate_animation.frame = 0
	result_panel.visible = false

func refresh() -> void:
	uncrate_button.disabled = (PlayerData.inventory["Crate"] <= 0 or PlayerData.cash < 60)

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
		get_prize("Spiderweb Silk")
	elif roll >= 5 and roll < 10:
		get_prize("Chaingun")
	elif roll >= 10 and roll < 15:
		get_prize("Spreadgun")
	elif roll >= 20 and roll < 25:
		get_prize("Shotgun")
	elif roll >= 25 and roll < 30:
		get_prize("Scattergun")
	elif roll >= 30 and roll < 35:
		get_prize("Flamer")
	elif roll >= 35 and roll < 40:
		get_prize("Burner")
	elif roll >= 40 and roll < 45:
		get_prize("Bolt")
	else:
		get_prize("Bomb")

func get_prize(prize_name) -> void:
	if prize_name in item_data.data:
		if prize_name in PlayerData.inventory:
			PlayerData.inventory[prize_name] = clamp(PlayerData.inventory[prize_name]+1,0,99)
			result_label.text = "Found a " + prize_name
			result_icon.texture = load(item_data.data[prize_name]["icon"])
