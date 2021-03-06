extends Enemy

var bomb_velocity = Vector2.ZERO
export var cooldown = 1.0

func _ready() -> void:
	$Aim/Gun.disabled = true
	$Aim/Bomber.cooldown = cooldown
	$Aim/Bomber.damage = 40

func destroyed() -> void:
	for child in $Turrets.get_children():
	#	$Turrets.remove_child(child)
		child.destroyed()
	var explosion = preload("res://src/Actors/Gun/Explosion.tscn")
	var explosion_instance = explosion.instance()
	explosion_instance.damage = 0
	explosion_instance.size_scale = 2
	explosion_instance.global_position = global_position
	ObjectRegistry.register_bullet(explosion_instance)
	if drop:
		var drop_instance = drop.instance()
		drop_instance.position = global_position
		ObjectRegistry.register_effect(drop_instance)
	queue_free()

func _physics_process(_delta):
	if entered_screen:
		$Aim/Bomber.bomb()
