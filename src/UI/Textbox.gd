extends Control

signal text_finished()
var page = "0"
var text_playing = true
var dialogue = {}
onready var nametag = $Panels/Center/Name
onready var text = $Panels/Center/Speech
onready var avatar = $Panels/Left/Profile
var text_dialogue = {
	"0": {"name": "Ava", "profile": "ava-base",
	"text": "The quick brown fox"},
	"1": {"name": "Ava", "profile": "ava-hurt",
	"text": "jumps over the lazy dog"},
	"2": {"name": "Ava", "profile": "ava-upset",
	"text": "again and again"},
}
var profiles = {
	"ava-base": preload("res://assets/avatars/ava-base.png"),
	"ava-hurt": preload("res://assets/avatars/ava-hurt.png"),
	"ava-upset": preload("res://assets/avatars/ava-upset.png")
}
var new_game_text = {
	"0": {"name": "Ava", "profile": "ava-base",
	"text": "Hello, captain. I am your onbard ship AI, Ava. Welcome to your main control panel!"},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "Here you can customize my outer chasis and my weapons loadout, or check my cargo inventory."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "We can go to the trading hub to buy equipment and sell loot, or go rob a train to get more loot."},
	"3": {"name": "Ava", "profile": "ava-base",
	"text": "Oh yeah, you're a train robber, apparently. But I don't judge. You do what you need to do to survive, captain."},
}
var chat_scenes = {
	0: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "Chat 0"},},
	1: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "Chat 1"},},
	2: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "Chat 2"},},
	3: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "Chat 3"},},
	4: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "Chat 4"},},
	5: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "I don't have anything interesting to say, sir."}}
}

func _ready() -> void:
	$Timer.wait_time = 0.02
	$Timer.autostart = true
	if $Timer.connect("timeout", self, "_on_timer_timeout") != OK:
		push_error("timer connect fail")

func play_dialogue(text_data) -> void:
	visible = true
	$Timer.start()
	dialogue = text_data
	page = "0"
	text.set_bbcode(dialogue[page]["text"])
	nametag.set_text(dialogue[page]["name"])
	avatar.set_texture(profiles[dialogue[page]["profile"]])
	text.set_visible_characters(0)
	set_process_input(true)

func _on_next() -> void:
	if text_playing:
		if text.get_visible_characters() > text.get_total_character_count():
			if int(page) < dialogue.size() - 1:
				page = str(int(page) + 1)
				text.set_bbcode(dialogue[page]["text"])
				nametag.set_text(dialogue[page]["name"])
				avatar.set_texture(profiles[dialogue[page]["profile"]])
				text.set_visible_characters(0)
			elif int(page) >= dialogue.size() - 1:
				end_text()
		else:
			text.set_visible_characters(text.get_total_character_count())

func _input(event) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_next()
	elif event.is_action_pressed("ui_cancel"):
		end_text()

func end_text() -> void:
	emit_signal("text_finished")
	visible = false

func _on_timer_timeout() -> void:
	text.set_visible_characters(text.get_visible_characters()+1)

func _on_next_pressed() -> void:
	_on_next()

func _on_skip_pressed() -> void:
	end_text()
