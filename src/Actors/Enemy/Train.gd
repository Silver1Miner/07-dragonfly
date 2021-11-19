extends KinematicBody2D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position.y = position.y
	position.x -= 10 * delta

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(20)
