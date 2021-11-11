extends Position2D

export var Bomb: PackedScene = load("res://src/Actors/Gun/Bomb.tscn")
var cooldown = 1.0

func _ready() -> void:
	pass

func bomb() -> void:
	if not $Timer.is_stopped() or not Bomb:
		return
	var bomb: Bomb = Bomb.instance()
	bomb.global_position = global_position
	if get_parent().get("velocity"):
		bomb.set_axis_velocity(get_parent().velocity)
	ObjectRegistry.register_bullet(bomb)
	$Timer.wait_time = cooldown
	$Timer.start()