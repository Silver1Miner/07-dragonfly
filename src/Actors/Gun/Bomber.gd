extends Position2D

export var Bomb: PackedScene = load("res://src/Actors/Gun/Bomb.tscn")
export var cooldown = 1.0
export var damage = 100
export var target_groups = ["enemy", "player"]

func bomb() -> void:
	if not $Timer.is_stopped() or not Bomb:
		return
	var bomb: Bomb = Bomb.instance()
	bomb.target_groups = target_groups
	bomb.global_position = global_position
	bomb.damage = damage
	if get_parent().get("velocity"):
		bomb.set_axis_velocity(get_parent().velocity)
	elif get_parent().get_parent().get("bomb_velocity"):
		bomb.set_axis_velocity(get_parent().get_parent().bomb_velocity)
	ObjectRegistry.register_bullet(bomb)
	$Timer.wait_time = cooldown
	$Timer.start()
	$AudioStreamPlayer2D.play()
