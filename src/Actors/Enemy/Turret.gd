extends Enemy
class_name Turret

var bullet_direction = Vector2.LEFT

func _ready() -> void:
	$Aim/Gun.load_gun_data("Enemy Turret Gun")

func _physics_process(_delta):
	$Aim.look_at(PlayerData.current_position)
	if entered_screen:
		$Aim/Gun.direction = (PlayerData.current_position - global_position).normalized()
