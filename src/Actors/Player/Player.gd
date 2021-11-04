extends KinematicBody2D
class_name Player

const SPEED_FAST := 500
const SPEED_SLOW := 100
const SPEED_NORMAL := 300
var speed := 300 # pixels/second
var velocity := Vector2.ZERO

var max_hp = 100
var hp = 100 setget _set_HP
var max_shield = 100
var shield = 100 setget _set_SH

signal hp_updated(hp)
signal shield_updated(shield)

func _ready() -> void:
	pass

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_pressed("speed_slow"):
		speed = SPEED_SLOW
	elif Input.is_action_pressed("speed_fast"):
		speed = SPEED_FAST
	else:
		speed = SPEED_NORMAL
	velocity = velocity.normalized() * speed
	if Input.is_action_pressed("fire_primary"):
		$Gun.fire()

func _physics_process(delta):
	get_input()
	var _collision = move_and_collide(velocity * delta)
	if position.x < 120 + 16:
		position.x = 120 + 16
	elif position.x > 520 - 16:
		position.x = 520 - 16
	if position.y < 0 + 16:
		position.y = 0 + 16
	elif position.y > 400 - 16:
		position.y = 400 - 16

func _set_HP(new_hp) -> void:
	var prev_hp = hp
	hp = clamp(new_hp, 0, max_hp)
	if hp != prev_hp:
		emit_signal("hp_updated", hp)
	if hp == 0:
		print("destroyed")

func _set_SH(new_shield) -> void:
	var prev_shield = shield
	shield = clamp(new_shield, 0, max_shield)
	if shield != prev_shield:
		emit_signal("shield_updated", shield)
