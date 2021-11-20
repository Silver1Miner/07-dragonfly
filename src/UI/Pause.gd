extends Control

signal leave()

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			if get_tree().paused:
				get_tree().paused = false
				visible = false
			else:
				pause()

func pause() -> void:
	$Failure.visible = false
	$Success.visible = false
	$cargo.visible = true
	$Options.visible = true
	$Options/leave.text = "Run Away!"
	get_tree().paused = true
	visible = true

func mission_failed() -> void:
	$cargo.visible = false
	$Options.visible = false
	$Failure.visible = true
	$Success.visible= false
	get_tree().paused = true
	visible = true

func end_mission() -> void:
	$Failure.visible = false
	$Success.visible = true
	$Options.visible = false
	get_tree().paused = true
	visible = true

func update_cargo_list(list: String) -> void:
	$cargo/cargo_pickups.text = list

func _on_unpause_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_leave_pressed() -> void:
	get_tree().paused = false
	emit_signal("leave")
	visible = false

func _on_Restart_pressed() -> void:
	get_tree().paused = false
	ObjectRegistry.clear_screen()
	if get_tree().reload_current_scene() != OK:
		push_error("failed to restart scene")

func _on_victory_end_pressed() -> void:
	get_tree().paused = false
	emit_signal("leave")
	visible = false
