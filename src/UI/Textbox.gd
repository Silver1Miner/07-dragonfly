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
	"ava-upset": preload("res://assets/avatars/ava-upset.png"),
	"ava-excited": preload("res://assets/avatars/ava-excited.png")
}
var new_game_text = {
	"0": {"name": "Ava", "profile": "ava-base",
	"text": "Hello, captain. I am your onbard ship AI, Ava. Welcome to your main control panel!"},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "Here you can customize my outer chasis and my weapons loadout, or check my cargo inventory."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "We can go to the trading hub to buy equipment and sell loot, or go rob a train to get more loot."},
}
var chat_scenes = {
	0: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "I have three main methods of attack: a primary gun, secondary gun, and bombs."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "Shooting guns drains my energy, but my generator automatically recharges over time."},
	"2": {"name": "Ava", "profile": "ava-excited",
	"text": "Bombs are great for dealing large damage to targets below us."},
	"3": {"name": "Ava", "profile": "ava-base",
	"text": "Unfortunately, while our guns energy recharges, we have a limited number of bombs. Be sure to stay stocked up!"},
	},
	1: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "While my hull is our last layer of defense, I also project an energy shield."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "My shield is rechargable too! If my generator is full, it diverts power to recharging the shield."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "If my shield falls low, you can hold off on firing my guns for a short while and wait for my shield to recharge!"},},
	2: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "The Old Man runs the trading hub. I don't know why he's called the Old Man though; he doesn't look very old."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "He's a great resource for us. He buys loot from us, and sells equipment and repairs."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "He also knows how to safely break open locked shipping crates, and will open any crate for us for a small fee."},},
	3: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "The Old Man is willing to buy unopened crates from us, or we can pay him to open crates for us."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "If we pay for a crate to be opened, we get to keep whatever's inside."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "Sometimes we don't find anything particularly useful, but occasionally we can find a rare and valuable treasure!"}},
	4: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "If a train robbery goes bad, we can run away at any time by pressing Escape."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "If we run away too early, we might not have enough loot to make up for any costs, like damage to my hull or bombs."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "On the other hand, it's probably better to take a small loss than to get blown up!"},},
	5: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "I don't have anything new or interesting to say, sir."},
	"1": {"name": "Ava", "profile": "ava-upset",
	"text": "I'll be repeating myself from now on. Sorry I couldn't be more interesting, sir."},
	}
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

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("fire_primary"):
		_on_next()
	elif event.is_action_pressed("ui_cancel") or event.is_action_pressed("fire_secondary"):
		end_text()

func end_text() -> void:
	emit_signal("text_finished")
	visible = false

func _on_timer_timeout() -> void:
	text.set_visible_characters(text.get_visible_characters()+1)

func _on_next_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/select_008.ogg")
	_on_next()

func _on_skip_pressed() -> void:
	AudioManager.play_sound("res://assets/Audio/ui/back_002.ogg")
	end_text()
