extends RigidBody2D
class_name Bomb

export var Explosion: PackedScene
export var damage = 100
export var target_groups = ["enemy", "player"]

func _ready() -> void:
	add_to_group("environmental")

func _process(_delta: float) -> void:
	if position.y > 400 + 16:
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
