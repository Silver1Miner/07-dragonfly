extends RigidBody2D
class_name Bomb

func _ready() -> void:
	set_axis_velocity(Vector2.LEFT * PlayerData.SCROLL_SPEED)

func _process(_delta: float) -> void:
	if position.y > 400 + 16:
		detonate()

func _on_Bomb_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		return
	detonate()

func detonate() -> void:
	print("detonated")
	queue_free()
