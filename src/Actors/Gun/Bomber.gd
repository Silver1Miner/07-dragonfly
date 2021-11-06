extends Position2D

export var Bomb: PackedScene
var cooldown = 1.0

func _ready() -> void:
	pass

func bomb() -> void:
	if not $Timer.is_stopped() or not Bomb:
		return
	var bomb: Bomb = Bomb.instance()
	bomb.global_position = global_position
	ObjectRegistry.register_bullet(bomb)
	$Timer.wait_time = cooldown
	$Timer.start()
