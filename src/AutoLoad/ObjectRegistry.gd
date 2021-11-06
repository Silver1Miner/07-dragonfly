extends Node

func register_bullet(bullet: Node) -> void:
	call_deferred("add_child", bullet)
