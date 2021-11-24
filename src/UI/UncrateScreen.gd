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
	uncrate_button.disabled = (PlayerData.inventory["Crate"] <= 0)
	update_crate_number(PlayerData.inventory["Crate"])
	crate_animation.frame = 0
	result_panel.visible = false

func update_crate_number(new_number) -> void:
	crate_number.text = "Crates Remaining: " + str(new_number)

func _on_Accept_pressed() -> void:
	uncrate_button.disabled = true
	decline_button.disabled = true
	crate_animation.play("open")
	roll()

func _on_Decline_pressed() -> void:
	visible = false

func _on_ResultClose_pressed() -> void:
	crate_animation.frame = 0
	crate_animation.playing = false
	result_panel.visible = false
	uncrate_button.disabled = (PlayerData.inventory["Crate"] <= 0)
	decline_button.disabled = false

func _on_AnimatedSprite_animation_finished() -> void:
	emit_signal("transaction")
	result_panel.visible = true

func roll() -> void:
	PlayerData.inventory["Crate"] = clamp(PlayerData.inventory["Crate"]-1, 0, 99)
	update_crate_number(PlayerData.inventory["Crate"])
	randomize()
	var roll = rand_range(0, 99)
	if roll < 1:
		get_prize("Spiderweb Silk")
	else:
		get_prize("Bomb")

func get_prize(prize_name) -> void:
	if prize_name in item_data.data:
		if prize_name in PlayerData.inventory:
			PlayerData.inventory[prize_name] = clamp(PlayerData.inventory[prize_name]+1,0,99)
			result_label.text = "Found a " + prize_name
			result_icon.texture = load(item_data.data[prize_name]["icon"])
