extends RigidBody2D
class_name Bomb

export var Explosion: PackedScene

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if position.y > 400 + 16:
		detonate()

func _on_Bomb_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		detonate()

func detonate() -> void:
	print("detonated")
	var explosion: Explosion = Explosion.instance()
	explosion.global_position = global_position
	ObjectRegistry.register_bullet(explosion)
	queue_free()
