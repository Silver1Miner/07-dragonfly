extends Control

signal leave()

var victory_music = preload("res://assets/Audio/Victory_Loop.ogg")
var defeat_music = preload("res://assets/Audio/Defeat_Loop.ogg")
var crates_gained := 0
onready var player = get_node("../Player")

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			if get_tree().paused:
				get_tree().paused = false
				visible = false
				$PauseMusic.stop()
			else:
				pause()

func pause() -> void:
	crates_gained = player.crates_gained
	update_cargo_list("Crates x" + str(crates_gained))
	$PauseMusic.stream = defeat_music
	$PauseMusic.play()
	$Failure.visible = false
	$Success.visible = false
	$cargo.visible = true
	$Options.visible = true
	$Options/leave.text = "Run Away!"
	get_tree().paused = true
	visible = true

func mission_failed() -> void:
	$PauseMusic.stream = defeat_music
	$PauseMusic.play()
	$cargo.visible = false
	$Options.visible = false
	$Failure.visible = true
	$Success.visible= false
	get_tree().paused = true
	visible = true

func end_mission() -> void:
	$PauseMusic.stream = victory_music
	$PauseMusic.play()
	$cargo.visible = true
	$Failure.visible = false
	$Success.visible = true
	$Options.visible = false
	get_tree().paused = true
	visible = true

func update_cargo_list(list: String) -> void:
	$cargo/cargo_pickups.text = list

func _on_unpause_pressed() -> void:
	$PauseMusic.stop()
	get_tree().paused = false
	visible = false

func _on_leave_pressed() -> void:
	$PauseMusic.stop()
	get_tree().paused = false
	emit_signal("leave")
	visible = false
	AudioManager.play_music("res://assets/Audio/Bridge_To_Your_Heart.mp3")

func _on_Restart_pressed() -> void:
	$PauseMusic.stop()
	get_tree().paused = false
	ObjectRegistry.clear_screen()
	if get_tree().reload_current_scene() != OK:
		push_error("failed to restart scene")

func _on_victory_end_pressed() -> void:
	$PauseMusic.stop()
	get_tree().paused = false
	emit_signal("leave")
	visible = false
	AudioManager.play_music("res://assets/Audio/Bridge_To_Your_Heart.mp3")
	#AudioManager.play_music("res://assets/Audio/LazyDragonfly.ogg", 1.334)
