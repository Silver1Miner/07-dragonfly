extends KinematicBody2D
class_name Enemy

export var speed := 50
export var direction := Vector2(-2,1)

var max_hp = 20
var hp = 20 setget _set_HP

func _ready() -> void:
	add_to_group("enemy")
	$Hitbox.add_to_group("enemy")
	set_bars()

func set_bars() -> void:
	$hp_bar.set_tint_progress(Color(1,0,0))
	$hp_bar.max_value = max_hp
	$hp_bar.value = hp

func _physics_process(delta):
	var velocity = speed * direction.normalized()
	var collision = move_and_collide(velocity * delta)
	if collision:
		direction.y = -direction.y
	if global_position.y < 40 + 16:
		direction.y = -direction.y
	elif global_position.y > 400 - 80 - 16:
		direction.y = -direction.y
	if global_position.x < 0 - 16:
		print("out of sight")
		queue_free()

func _set_HP(new_hp) -> void:
	var prev_hp = hp
	hp = clamp(new_hp, 0, max_hp)
	if hp != prev_hp:
		$hp_bar.value = hp
	if hp <= 0:
		destroyed()

func destroyed() -> void:
	print("destroyed")
	var explosion = preload("res://src/Actors/Gun/Explosion.tscn")
	var explosion_instance = explosion.instance()
	explosion_instance.damage = 0
	explosion_instance.size_scale = 1
	explosion_instance.global_position = global_position
	ObjectRegistry.register_bullet(explosion_instance)
	queue_free()

func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		_set_HP(hp - area.get_parent().hp)
	elif area.is_in_group("player_bullet") or area.is_in_group("environmental"):
		_set_HP(hp - area.damage)
