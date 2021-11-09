extends Resource

func get_lore(type: String, index: int) -> String:
	return lore[type][index]

var lore = {
	"ship": [
"""The Dragonfly Class airship
"""
	]
}
