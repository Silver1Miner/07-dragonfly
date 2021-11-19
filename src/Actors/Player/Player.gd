extends KinematicBody2D
class_name Player

const SPEED_FAST := 300
const SPEED_SLOW := 100
const SPEED_NORMAL := 200
var speed := 300 # pixels/second
var velocity := Vector2.ZERO
var invincible = false

var max_cash = 999999
var cash = 0 setget _set_cash
var max_hp = 100
var hp = 80 setget _set_HP
var prev_hp = 100
var max_shield = 100
var shield = 80 setget _set_SH
var max_energy = 100
var energy = 100 setget _set_EN
var recharge_rate = 40
var bombs = 0
var max_bombs = 99
var weapon_1 = "Empty"
var weapon_2 = "Empty"
var cargo = []

signal hp_updated(hp, prev_hp, max_hp)
signal shield_updated(shield, max_shield)
signal energy_updated(energy, max_energy)
signal bombs_updated(bombs, max_bombs)
signal loadout_updated(weapon_1, weapon_2)
signal cash_updated(cash)
signal player_destroyed()

func _ready() -> void:
	add_to_group("player")
	$Hitbox.add_to_group("player_pickup")
	#$Pickup_Area.add_to_group("player")
	$Shield.add_to_group("player")
	load_player_data()
	$Gun.load_gun_data(weapon_1)
	$Gun2.load_gun_data(weapon_2)
	$Bomber.target_groups = ["enemy"]
	set_bars()

var wing_locations
func load_player_data() -> void:
	cash = PlayerData.cash
	weapon_1 = PlayerData.player_weapon_1
	weapon_2 = PlayerData.player_weapon_2
	hp = PlayerData.player_hp
	prev_hp = PlayerData.player_hp
	shield = PlayerData.player_shield
	bombs = PlayerData.inventory["Bombs"]
	$Sprite.texture = PlayerData.ship_visuals[PlayerData.current_ship]["sprite"]
	$AnimatedSprite.position = PlayerData.ship_visuals[PlayerData.current_ship]["wings"]

func save_player_data() -> void:
	PlayerData.cash = cash
	PlayerData.player_hp = hp
	PlayerData.player_shield = shield
	PlayerData.inventory["Bombs"] = bombs

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

func update_display() -> void:
	emit_signal("cash_updated", cash)
	emit_signal("hp_updated", hp, prev_hp, max_hp)
	emit_signal("shield_updated",shield, max_shield)
	emit_signal("energy_updated",energy, max_energy)
	emit_signal("bombs_updated",bombs, max_bombs)
	emit_signal("loadout_updated", weapon_1, weapon_2)

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
		if !$Gun.disabled and $Gun/Timer.is_stopped() and energy > $Gun.get_energy_cost():
			$Gun.fire()
			_set_EN(energy - $Gun.get_energy_cost())
	if Input.is_action_pressed("fire_secondary"):
		if !$Gun2.disabled and $Gun2/Timer.is_stopped() and energy > $Gun2.get_energy_cost():
			$Gun2.fire()
			_set_EN(energy - $Gun2.get_energy_cost())
	if Input.is_action_pressed("fire_tertiary"):
		if $Bomber/Timer.is_stopped() and bombs > 0:
			$Bomber.bomb()
			_set_bombs(bombs - 1)

var accumulated = 0
func _physics_process(delta):
	PlayerData.current_position = global_position
	if invincible:
		$AnimationPlayer.play("flash")
	else:
		$AnimationPlayer.play("RESET")
	get_input()
	var _collision = move_and_collide(velocity * delta)
	if position.x < 16:
		position.x = 16
	elif position.x > 640 - 16:
		position.x = 640 - 16
	if position.y < 40 + 16:
		position.y = 40 + 16
	elif position.y > 400 - 16:
		position.y = 400 - 16
	_set_EN(energy + recharge_rate * delta)
	accumulated += 1
	if accumulated >= 120:
		recharge_shield()
		accumulated = 0

func recharge_shield() -> void:
	if energy == max_energy:
		_set_SH(shield + 1)

func _set_cash(new_cash) -> void:
	var prev_cash = cash
	cash = clamp(new_cash, 0, max_cash)
	if cash != prev_cash:
		emit_signal("cash_updated", new_cash)

func _set_HP(new_hp) -> void:
	prev_hp = hp
	hp = clamp(new_hp, 0, max_hp)
	if hp != prev_hp:
		$hp_bar.value = hp
		emit_signal("hp_updated", hp, prev_hp, max_hp)
	if hp == 0:
		emit_signal("player_destroyed")
		print("destroyed")
		visible = false

func _set_SH(new_shield) -> void:
	var prev_shield = shield
	shield = clamp(new_shield, 0, max_shield)
	if shield != prev_shield:
		$shield_bar.value = shield
		emit_signal("shield_updated", shield, max_shield)
	if shield <= 0.0:
		$Shield.visible = false
		$Shield/CollisionShape2D.shape.radius = 0
		accumulated = -300
	else:
		$Shield.visible = true
		$Shield/CollisionShape2D.shape.radius = 16
		accumulated = -300

func _set_EN(new_energy) -> void:
	var prev_energy = energy
	energy = clamp(new_energy, 0, max_energy)
	if energy != prev_energy:
		$energy_bar.value = energy
		emit_signal("energy_updated", energy, max_energy)

func _set_bombs(new_bombs) -> void:
	var prev_bombs = bombs
	bombs = clamp(new_bombs, 0, max_bombs)
	if bombs != prev_bombs:
		emit_signal("bombs_updated", bombs, max_bombs)

func take_damage(damage_value: float) -> void:
	if invincible:
		return
	if shield > 0:
		_set_SH(shield - damage_value)
	else:
		_set_HP(hp - damage_value)
		invincible = true
		$Timer.start()

func add_cargo(name) -> void:
	cargo.append(name)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and area.get_parent().has_method("take_damage"):
		area.get_parent().drop = null
		area.get_parent().take_damage(hp)

func _on_Shield_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and area.get_parent().has_method("take_damage"):
		area.get_parent().drop = null
		area.get_parent().take_damage(shield)

func _on_Timer_timeout() -> void:
	invincible = false
