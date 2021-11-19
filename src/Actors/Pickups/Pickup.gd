extends Area2D
class_name Pickup

export (PackedScene) var FCT = preload("res://src/Actors/Effects/FCT.tscn")
export var effect_name: String = "+25 HP"
export var speed := 30
export var direction := Vector2.LEFT

func _process(delta: float) -> void:
	position += (delta * speed) * direction.normalized()
	if global_position.x < 0 - 36:
		print("out of sight")
		queue_free()

func _on_Pickup_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		var fct = FCT.instance()
		get_parent().get_parent().add_child(fct)
		fct.rect_position = get_global_position() + Vector2(0, -16)
		fct.show_value(effect_name, Vector2(0,-8), 2, PI/2)
		match effect_name:
			"+25 HP":
				area.get_parent()._set_HP(area.get_parent().hp + 25)
			"+25 SH":
				area.get_parent()._set_SH(area.get_parent().shield + 25)
			"+25 EN":
				area.get_parent()._set_EN(area.get_parent().energy + 25)
			"+25 CASH":
				area.get_parent()._set_cash(area.get_parent().cash + 25)
			"+1 BOMB":
				area.get_parent().set_bombs(area.get_parent().bombs + 1)
			"+1 CRATE":
				area.get_parent().add_cargo("crate")
		queue_free()

func _on_Timer_timeout() -> void:
	queue_free()
