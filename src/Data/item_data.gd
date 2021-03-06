extends Resource

func get_entry(name: String, entry: String) -> String:
	if name in data:
		return data[name][entry]
	return "entry not found"

func has(item: String) -> bool:
	return item in data

func get_stats(type: String) -> Dictionary:
	if type in data:
		return data[type]
	return {}

func get_lore(index) -> String:
	if index < len(lore):
		return lore[index]["text"]
	return "lore entry not found"

var lore = [
	{"name": "Hive",
"text": """Due to its relatively central location among the known planetary systems, Hive is a popular intermediary transportation hub. Of course, as all planetary systems are in constant motion relative to one another, there is no such thing as a constant shipping lane in space. Nevertheless Hive intercepts more calculated transportation routes than any other colonized planet, and so all space shipping corporations have invested heavily in Hive.

However, the primacy of Hive as a transportation hub and transformation into a company planet was not always assured, due to a local quirk: the strong religious feelings of the locals.

In the dominant religious beliefs of Hive, all Artificial Intelligence (AI) is considered heretical, a crime against the sanctity of human consciousness. Consequently, ownership of AI equipment is completely illegal under traditional planetary law. Anyone discovered to have possession of AI equipment is subject to punishment reaching up to familial extermination.

This initially caused some difficulties for the shipping corporations due to their heavy reliance on powerful computers to calculate transportation routes among the constantly moving planetary systems. However, the issue was eventually resolved by the declaration of the principle of distinguishability between 'computation power' and 'intelligence' made in the now famous 'Abacus' argument in the landmark 'Unter Freight vs Hive' case.

The 'Abacus' argument states that as a mechanical abacus made of sliding beads cannot be considered intelligent, any computational equipment that can be demonstrated to be reducable to an abacus cannot be considered 'Intelligent,' no matter how great its computational power.

Despite Unter Freight's victory in the case, the logic of the argument has not been completely accepted by the more devout locals of Hive, and for this reason most computational equipment used by the shipping corporations are kept off the planet's surface, or else under very heavy guard.
"""},
	{"name": "Old Man of the Moon",
"text": """The Old Man below the Moon appears in several ancient legends about love and marriage. He is said to use a red string to tie together future mates. Legends vary as to where he ties the strings, such as the ankle or around a finger.

Despite the age of the story, it has gained a resurgence of popularity in more recent times, albeit in a slightly modified form.

In the modern myth, pirates, bandits, and thieves pass around stories of an old man who is a perfect supplier, middle man, and fence, willing to buy and able to sell anything they desire.

All major shipping corporations, governments, and private security firms have continuously issued statements that there is no truth to this modern myth and that no such Old Man exists.
"""},
	{"name": "Unter Freight",
"text": """Unter Freight is a railway shipping company with strong ties to the Relentless Shipping congolomerate. Unter maintains the single largest railway network on the planet, colloquially known as 'The Spider Web,' on which it runs its freight trains, colloquially known as 'the Silk Worms.'

Unfortunately, this position has made Unter a popular target for pirates, who often attempt to rob their trains in transit. For this reason, Unter has invested heavily in arming its trains with defense turrets, deploying escort drones, and contracting private security firms to deal with such annoyances.
"""},
	{"name": "Banned Ships",
"text": """By order of the Unter Freight company:

The following airships are banned due to their popularity among pirate groups:

Dragonfly
Scarab
Scorpion

Any airship of these models will be assumed to be a pirate and shot on sight.
"""},
	{"name": "Bounty Hunter's Letter",
"text": """A fragment from a damaged letter:

'...through me. You're not special you know.

Did you think that you're the only one the Old Man has tricked into doing his dirty work?

He's got hundreds of naive fools just like you. The Bug job, the Star Scope job, every single one was the same: a naive kid he tricked into doing his dirty work, only to get blown up by me in the end.

I've already taken out hundreds of other little pirates he made into his little puppets. Keep this up, and you'll be the next to...'
"""},
]

var data = {
	"Repairs": {
		"lore": """Repair your ship to full hull integrity""",
		"buy_cost": 100,
		"sell_price": 100,
		"icon": "res://assets/items/icon.png",
	},
	"Dragonfly": {
			"lore": """The Dragonfly Class ornithopter airship is immediately recognizable for its bright colors and agile flight. Despite some superficial similarities, it should not be confused with the Firefly class airship."""},
	"Scarab": {
		"lore": """The Scarab Class ornithopter airship, known for its bright metallic color, was originally a popular choice for recycling and sanitation companies."""},
	"Scorpion": {
		"lore": """The Scorpion Class ornithopter airship, named for the positioning of its mounted weapons, was originally designed for use in private security but soon abandoned for newer models."""},
	"Raw Spiderweb Silk": {
		"lore": """A valuable commodity, light and yet more durable than steel. In addition to industrial applications, it is also woven into textiles, and even used as a medium of exchange in some regions.""",
		"buy_cost": 5000,
		"sell_price": 1000,
		"icon": "res://assets/items/Tent.png",
	},
	"Silverfish Coins": {
		"lore": """A discontinued currency made from silver. It became colloquially known as 'silverfish,' a nocturnal insect pest, due to its continued use by piracy groups.""",
		"buy_cost": 3000,
		"sell_price": 800,
		"icon": "res://assets/items/coins_silver.png",
	},
	"Gold Bugs": {
		"lore": """A discontinued currency. It is now legal to melt these down for their gold, and many corporations are doing just that.""",
		"buy_cost": 6000,
		"sell_price": 2000,
		"icon": "res://assets/items/coins_gold.png"
	},
	"Chitin Shell": {
		"lore": """An experimental new type of exoskeleton armor modeled after the shells of arthropods and insects.""",
		"buy_cost": 1000,
		"sell_price": 200,
		"icon": "res://assets/items/armor_04.png"
	},
	"Spiderweb Silk Shirt": {
		"lore": """A light and comfortable shirt crafted from the finest spider silks, very popular among the wealhty.""",
		"buy_cost": 2000,
		"sell_price": 400,
		"icon": "res://assets/items/shirt_01.png"
	},
	"Water": {
		"lore": """A very valuable commodity on a desert planet.""",
		"buy_cost": 1000,
		"sell_price": 100,
		"icon": "res://assets/items/water.png"
	},
	"Watermelon": {
		"lore": """A popular snack for metal beetles.""",
		"buy_cost": 1000,
		"sell_price": 120,
		"icon": "res://assets/items/watermelon.png"
	},
	"Bomb": {
		"lore": """Bombs pack a lot of punch, but can only be dropped. Gravity has to take care of the rest. Their initial speed depends on your speed, so I hope you paid attention to your physics classes!""",
		"baseprice": 1000,
		"buy_cost": 50,
		"sell_price": 50,
		"icon": "res://assets/guns/tile_0012.png"
	},
	"Crate": {
		"lore": """A locked and unopened shipping crate. It costs a fee to break open, but who knows what treasures could be contained inside?""",
		"buy_cost": 100,
		"sell_price": 100,
		"icon": "res://assets/crates/treasure chest0000.png"
	},
	"Chaingun": {
		"lore": """The Clavata 'Bullet Ant' Chaingun is an old but reliable rapid-fire weapon that boasts near pin-point accuracy.""",
		"baseprice": 1000,
		"buy_cost": 600,
		"sell_price": 500,
		"damage": 3.0,
		"cooldown": 0.08,
		"direction": Vector2.RIGHT,
		"speed": 300,
		"lifetime": 3.0,
		"energy_cost": 8.0,
		"target_groups": ["enemy", "environmental"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 1,
		"angle": 0,
		"bullet": preload("res://src/Actors/Gun/Bullet.tscn"),
		"sound": "res://assets/Audio/guns/258257__wadaltmon__m3-grease-gun-firing.wav",
		"icon": "res://assets/guns/milit.png"
	},
	"Spreadgun": {
		"lore": """The Myrmecia Spreadgun is a multi-barreled rapid-fire weapon generally used by security forces for suppressive fire and crowd control.""",
		"baseprice": 1000,
		"buy_cost": 800,
		"sell_price": 700,
		"damage": 3.0,
		"cooldown": 0.1,
		"direction": Vector2.RIGHT,
		"speed": 300,
		"lifetime": 3.0,
		"energy_cost": 10.0,
		"target_groups": ["enemy", "environmental"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 2,
		"angle": 5,
		"bullet": preload("res://src/Actors/Gun/Bullet.tscn"),
		"sound": "res://assets/Audio/guns/258198__wadaltmon__thompson-smg-shot.wav",
		"icon": "res://assets/guns/md5.png"
	},
	"Shotgun": {
		"lore": """The Goliath Beetle Burst gun was originally used in mining and demolition, clearning obstacles through a burst of powerful short-range energy pellets.""",
		"baseprice": 1000,
		"buy_cost": 1000,
		"sell_price": 800,
		"damage": 25.0,
		"cooldown": 0.8,
		"direction": Vector2.RIGHT,
		"speed": 900,
		"lifetime": 0.2,
		"energy_cost": 40.0,
		"target_groups": ["enemy","environmental"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 4,
		"angle": 4,
		"bullet": preload("res://src/Actors/Gun/Bullet.tscn"),
		"sound": "res://assets/Audio/guns/163455__lemudcrab__shotgun-shot.wav",
		"icon": "res://assets/guns/x90.png",
	},
	"Scattergun": {
		"lore": """The Titan Beetle Burst gun was a prototype demolition tool that uses short-range energy pellets, eventually abandoned due to the difficulties in limiting pellet spread.""",
		"baseprice": 1000,
		"buy_cost": 1200,
		"sell_price": 1000,
		"damage": 28.0,
		"cooldown": 0.9,
		"direction": Vector2.RIGHT,
		"speed": 900,
		"lifetime": 0.15,
		"energy_cost": 50.0,
		"target_groups": ["enemy", "environmental"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 6,
		"angle": 5,
		"bullet": preload("res://src/Actors/Gun/Bullet.tscn"),
		"sound": "res://assets/Audio/guns/522484__filmmakersmanual__shotgun-firing-2.wav",
		"icon": "res://assets/guns/raging_pitbull.png"
	},
	"Flamer": {
		"lore": """The Bombardier Beetle Flamer was invented to serve the functions of an airship flamethrower while technically not being a flamethrower. It was nevertheless banned under planetary law immediately after release.""",
		"baseprice": 1000,
		"buy_cost": 1200,
		"sell_price": 1000,
		"damage": 2.5,
		"cooldown": 0.1,
		"direction": Vector2.RIGHT,
		"speed": 600,
		"lifetime": 0.4,
		"energy_cost": 10.0,
		"target_groups": ["enemy", "environmental"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 3,
		"angle": 5,
		"bullet": preload("res://src/Actors/Gun/Bullet_Flame.tscn"),
		"sound": "res://assets/Audio/guns/381862__cribbler__fireblast-lightly.wav",
		"icon": "res://assets/guns/mg5000.png",
	},
	"Burner": {
		"lore": """The Firebug Burner is technically not a flamethrower but a long range torch. However, the tool has nevertheless been classified as a flamethrower under planetary law in order to regulate ownership.""",
		"baseprice": 1000,
		"buy_cost": 1500,
		"sell_price": 1200,
		"damage": 3.0,
		"cooldown": 0.1,
		"direction": Vector2.RIGHT,
		"speed": 800,
		"lifetime": 0.2,
		"energy_cost": 10.0,
		"target_groups": ["enemy", "environmental"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 2,
		"angle": 2,
		"bullet": preload("res://src/Actors/Gun/Bullet_Flame.tscn"),
		"sound": "res://assets/Audio/guns/447941__breviceps__blast-flamethrower-cooldown.wav",
		"icon": "res://assets/guns/mg6000.png",
	},
	"Bolt": {
		"lore": """The Scorpion Stinger Bolt Beam is a scaled-down version of the now infamous Bolt Beam that is a favorite of space pirates. Though smaller in absolute size, it is, pound for pound, even more dangerous in atmospheric air battles than its big brother is in space.""",
		"baseprice": 1000,
		"buy_cost": 4000,
		"sell_price": 2000,
		"damage": 30.0,
		"cooldown": 1.0,
		"direction": Vector2.RIGHT,
		"speed": 0,
		"lifetime": 0.5,
		"energy_cost": 80.0,
		"target_groups": ["enemy", "environmental"],
		"bullet_groups": ["player_bullet"],
		"bullet_number": 1,
		"angle": 15,
		"bullet": preload("res://src/Actors/Gun/Bullet_Bolt.tscn"),
		"sound": "res://assets/Audio/guns/517058__invisible-inks__scifi-sniper-rifle.ogg",
		"icon": "res://assets/guns/pow9.png"
	},
	"Enemy Chain Gun": {
		"lore": "A cheap gun often used by private security forces",
		"baseprice": 0,
		"buy_cost": 100,
		"sell_price": 100,
		"damage": 20.0,
		"cooldown": 2.0,
		"direction": Vector2.LEFT,
		"speed": 100,
		"lifetime": 15.0,
		"energy_cost": 0,
		"target_groups": ["player"],
		"bullet_groups": ["enemy_bullet"],
		"bullet_number": 1,
		"angle": 15,
		"bullet": preload("res://src/Actors/Gun/Bullet_Enemy.tscn"),
		"sound": "res://assets/Audio/guns/258198__wadaltmon__thompson-smg-shot.wav",
	},
	"Enemy Turret Gun": {
		"lore": "A cheap gun often used by private security forces",
		"baseprice": 0,
		"buy_cost": 100,
		"sell_price": 100,
		"damage": 20.0,
		"cooldown": 3.0,
		"direction": Vector2.LEFT,
		"speed": 80,
		"lifetime": 20.0,
		"energy_cost": 0,
		"target_groups": ["player"],
		"bullet_groups": ["enemy_bullet"],
		"bullet_number": 1,
		"angle": 15,
		"bullet": preload("res://src/Actors/Gun/Bullet_Enemy_turret.tscn"),
		"sound": "res://assets/Audio/guns/163455__lemudcrab__shotgun-shot.wav"
	}
}
