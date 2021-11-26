extends ColorRect

var current_slot = 0
onready var slot_list = $Save/Display/ItemList
onready var save_button = $Save/Display/Save
onready var load_button = $Save/Display/Load

func _ready() -> void:
	load_slot_names()

func load_slot_names() -> void:
	slot_list.clear()
	for i in range(3):
		slot_list.add_item("Save Slot " + str(i+1))
	save_button.disabled = true
	load_button.disabled = true

func _on_Close_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/back_002.ogg")
	visible = false

func _on_Load_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_005.ogg")
	print("load file ", str(current_slot))
	PlayerData.load_data(PlayerData.load_game(current_slot))
	visible = false
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")

func _on_Save_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_005.ogg")
	PlayerData.save_game(current_slot)
	print("save file ", str(current_slot))
	visible = false


func _on_ItemList_item_selected(index: int) -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	current_slot = index
	print(current_slot)
	save_button.disabled = false
	load_button.disabled = false


func _on_ToMain_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/back_002.ogg")
	AudioManager.stop()
	if get_tree().change_scene_to(PlayerData.main_menu) != OK:
		push_error("fail to change scene")
