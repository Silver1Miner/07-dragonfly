extends Control

signal leave()

func _ready() -> void:
	visible = false

func pause() -> void:
	$Options/leave.text = "Run Away!"
	get_tree().paused = true
	visible = true

func end_mission() -> void:
	$Options/unpause.visible = false
	$Options/leave.text = "Return to Hub"

func update_cargo_list(list: String) -> void:
	$cargo_pickups.text = list

func _on_unpause_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_leave_pressed() -> void:
	get_tree().paused = false
	emit_signal("leave")
	visible = false
