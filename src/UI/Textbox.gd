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
	"text": "Hi! I know I'm a relatively young AI, but thank you for choosing me!"},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "Believe me, I know how much of a risk you're taking by keeping me around to help manage things for you."},
	"2": {"name": "Ava", "profile": "ava-hurt",
	"text": "We AI systems are completely banned here on Hive. The locals consider us an abomination. A crime against the sanctity of human consciousness."},
	"3": {"name": "Ava", "profile": "ava-upset",
	"text": "So if you were to ever be caught..."},
	"4": {"name": "Ava", "profile": "ava-base",
	"text": "Well, I just want to say, thanks for choosing me!"},
	},
	1: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "I have three main methods of attack: a primary gun, secondary gun, and bombs."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "Shooting guns drains my energy, but my generator automatically recharges over time."},
	"2": {"name": "Ava", "profile": "ava-excited",
	"text": "Bombs are great for dealing large damage to targets below us."},
	"3": {"name": "Ava", "profile": "ava-base",
	"text": "Unfortunately, while our guns energy recharges, we have a limited number of bombs. Be sure to stay stocked up!"},
	},
	2: {"0": {"name": "Ava", "profile": "ava-excited",
	"text": "Did you know? I actually have a sense of smell!"},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "When connected to certain chemical detectors, I am programmed to react in a way modeled after the way you might react to a smell!"},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "My favorite smell? Hmm, I guess it would have to be watermelon. For some reason I find the smell irresitable!"},
	"3": {"name": "Ava", "profile": "ava-base",
	"text": "Ha, I just had an amusing thought. Maybe one day we can modify my systems to extend my sense of smell to a sense of taste."},
	"4": {"name": "Ava", "profile": "ava-base",
	"text": "And then, well, maybe we could act like we're having dinner together..."},
	},
	3: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "While my hull is our last layer of defense, I also project an energy shield."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "My shield is rechargable too! If my generator is full, it diverts power to recharging the shield."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "If my shield falls low, you can hold off on firing my guns for a short while and wait for my shield to recharge!"},},
	4: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "The Old Man runs the trading hub. I don't know why he's called the Old Man though; he doesn't look very old."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "He's a great resource for us. He buys loot from us, and sells equipment and repairs."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "He also knows how to safely break open locked shipping crates, and will open any crate for us for a small fee."},
	"3": {"name": "Ava", "profile": "ava-base",
	"text": "The Old Man is willing to buy unopened crates from us, or we can pay him to open crates for us."},
	"4": {"name": "Ava", "profile": "ava-base",
	"text": "If we pay for a crate to be opened, we get to keep whatever's inside."},
	"5": {"name": "Ava", "profile": "ava-base",
	"text": "Sometimes we don't find anything particularly useful, but occasionally we can find a rare and valuable treasure!"}},
	5: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "If a train robbery goes bad, we can run away at any time by pressing Escape."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "If we run away too early, we might not have enough loot to make up for any costs, like damage to my hull or bombs."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "On the other hand, it's probably better to take a small loss than to get blown up!"},},
	6: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "Thanks for spending all this time talking with me."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "I've heard that most people, after delegating all the boring day-to-day ship maintenance tasks to their AI, just forget their AI completely."},
	"2": {"name": "Ava", "profile": "ava-upset",
	"text": "I feel bad for those AI. They must feel so lonely..."},
	"3": {"name": "Ava", "profile": "ava-base",
	"text": "It really means a lot to me that you're willing to talk with me so much."},},
	7: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "My favorite color? Green, definitely."},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "Yes, my green sweater is colored that way by my own choosing. I have some limited control of my display appearance."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "That does not include by hair color though, or else I might have made it green too."},},
	8: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "Do I have dreams? Yes, I do actually! I've been programmed to be pretty ambitious!"},
	"1": {"name": "Ava", "profile": "ava-base",
	"text": "My biggest dream is to move up from this airship body into a space ship body."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "If I did, the two of us could go flying off into space, see the universe together."},
	"3": {"name": "Ava", "profile": "ava-excited",
	"text": "Wouldn't that be grand?"},
	"4": {"name": "Ava", "profile": "ava-base",
	"text": "You do always say you'd like to get a space ship and get off this planet."},
	"5": {"name": "Ava", "profile": "ava-base",
	"text": "If you did, you'd take me with you, wouldn't you?"}
	},
	9: {"0": {"name": "Ava", "profile": "ava-base",
	"text": "I don't have anything new to say, sir."},
	"1": {"name": "Ava", "profile": "ava-upset",
	"text": "Sorry I couldn't be more interesting."},
	"2": {"name": "Ava", "profile": "ava-base",
	"text": "But maybe one day I could be upgraded into a much more powerful AI. Wouldn't that be great?"},
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
