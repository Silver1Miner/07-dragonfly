extends KinematicBody2D
class_name Enemy

export var speed := 50
export var direction := Vector2.DOWN

var max_hp = 20
var hp = 20 setget _set_HP

func _ready() -> void:
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
		direction.x = -direction.x
	if position.x < 120 + 16:
		direction.x = -direction.x
	elif position.x > 520 - 16:
		direction.x = -direction.x
	if position.y > 400 + 16:
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
	speed = 0


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		_set_HP(hp - area.get_parent().hp)
	elif area.is_in_group("player_bullet"):
		_set_HP(hp - area.damage)
