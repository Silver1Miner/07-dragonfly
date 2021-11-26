extends Control

func _ready() -> void:
	if OS.get_name() == "HTML5":
		$Options/quit.visible = false
	if !AudioManager.playing:
		AudioManager.play_music("res://assets/Audio/LazyDragonfly.ogg", 0)

func _on_new_pressed() -> void:
	print("new game")
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	PlayerData.new_game = true
	if get_tree().change_scene_to(PlayerData.text_scroll) != OK:
		push_error("fail to change scene")

func _on_load_pressed() -> void:
	PlayerData.load_data()
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")

func _on_settings_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	$Settings.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()
