extends Control

func _ready() -> void:
	if OS.get_name() == "HTML5":
		$Options/quit.visible = false

func _on_new_pressed() -> void:
	print("new game")
	PlayerData.new_game = true
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")

func _on_load_pressed() -> void:
	print("load game")
	if get_tree().change_scene_to(PlayerData.hub) != OK:
		push_error("fail to change scene")

func _on_settings_pressed() -> void:
	$Settings.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()
