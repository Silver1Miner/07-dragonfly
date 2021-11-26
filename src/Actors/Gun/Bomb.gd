extends RigidBody2D
class_name Bomb

export var hp = 5
export var Explosion: PackedScene
export var damage = 100
export var target_groups = ["enemy", "player"]

func _ready() -> void:
	add_to_group("environmental")
	$Hitbox.add_to_group("environmental")

func _process(_delta: float) -> void:
	$Sprite.rotation = linear_velocity.angle()
	if position.y > 400:
		detonate()

func take_damage(damage_value: float) -> void:
	hp -= damage_value
	if hp <= 0:
		detonate()

func _on_Bomb_body_entered(body: Node) -> void:
	for target in target_groups:
		if body.is_in_group(target) or body.is_in_group("environmental"):
			detonate()

func detonate() -> void:
	var explosion: Explosion = Explosion.instance()
	explosion.damage = damage
	explosion.global_position = global_position
	ObjectRegistry.register_bullet(explosion)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
