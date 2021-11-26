extends ColorRect

func _ready() -> void:
	visible = false


func _on_back_pressed() -> void:
	visible = false


func _on_MusicVolume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"), linear2db(value)
	)

func _on_SoundVolume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Sound"), linear2db(value)
	)


func _on_credits_pressed() -> void:
	PlayerData.new_game = false
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	if get_tree().change_scene_to(PlayerData.text_scroll) != OK:
		push_error("fail to change scene")
