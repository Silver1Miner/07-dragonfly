extends KinematicBody2D
class_name Player

const SPEED_FAST := 300
const SPEED_SLOW := 100
const SPEED_NORMAL := 200
var speed := 300 # pixels/second
var velocity := Vector2.ZERO

var max_hp = 100
var hp = 80 setget _set_HP
var max_shield = 100
var shield = 80 setget _set_SH
var max_energy = 100
var energy = 100 setget _set_EN
var recharge_rate = 40
var bombs = 10

signal hp_updated(hp)
signal shield_updated(shield)
signal energy_updated(energy)

func _ready() -> void:
	add_to_group("player")
	$Gun.add_to_group("player_bullet")
	$Gun.target_groups = ["enemy"]
	set_bars()

func set_bars() -> void:
	$hp_bar.set_tint_progress(Color(1,0,0))
	$shield_bar.set_tint_progress(Color(0,0,1))
	$energy_bar.set_tint_progress(Color(0,1,0))
	$hp_bar.max_value = max_hp
	$hp_bar.value = hp
	$shield_bar.max_value = max_shield
	$shield_bar.value = shield
	$energy_bar.max_value = max_energy
	$energy_bar.value = energy

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
		if $Gun/Timer.is_stopped() and energy > $Gun.get_energy_cost():
			$Gun.fire()
			_set_EN(energy - $Gun.get_energy_cost())
	if Input.is_action_pressed("fire_secondary"):
		if $Bomber/Timer.is_stopped() and bombs > 0:
			$Bomber.bomb()
			#bombs -= 1
			print(bombs)

var accumulated = 0
func _physics_process(delta):
	get_input()
	var _collision = move_and_collide(velocity * delta)
	if position.x < 16:
		position.x = 16
	elif position.x > 640 - 16:
		position.x = 640 - 16
	if position.y < 40 + 16:
		position.y = 40 + 16
	elif position.y > 400 - 80 - 16:
		position.y = 400 - 80 - 16
	_set_EN(energy + recharge_rate * delta)
	accumulated += 1
	if accumulated >= 60:
		recharge_shield()
		accumulated = 0

func recharge_shield() -> void:
	if energy == max_energy:
		_set_SH(shield + 1)
	#_set_EN(energy + recharge_rate)

func _set_HP(new_hp) -> void:
	var prev_hp = hp
	hp = clamp(new_hp, 0, max_hp)
	if hp != prev_hp:
		$hp_bar.value = hp
		emit_signal("hp_updated", hp)
	if hp == 0:
		print("destroyed")

func _set_SH(new_shield) -> void:
	var prev_shield = shield
	shield = clamp(new_shield, 0, max_shield)
	if shield != prev_shield:
		$shield_bar.value = shield
		emit_signal("shield_updated", shield)
	if shield <= 0:
		$Shield.visible = false
	else:
		$Shield.visible = true

func _set_EN(new_energy) -> void:
	var prev_energy = energy
	energy = clamp(new_energy, 0, max_energy)
	if energy != prev_energy:
		$energy_bar.value = energy
		emit_signal("energy_updated", energy)
