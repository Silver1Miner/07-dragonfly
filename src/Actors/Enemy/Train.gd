extends KinematicBody2D

var velocity = Vector2(-10, 0)

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	var _collision = move_and_collide(velocity * delta)


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(20)
