extends Enemy
class_name Turret

var bullet_direction = Vector2.LEFT

func _ready() -> void:
	$Gun.load_gun_data("Enemy Turret Gun")

func _physics_process(_delta):
	$GunSprite.look_at(PlayerData.current_position)
	if activated and entered_screen:
		$Gun.direction = (PlayerData.current_position - global_position).normalized()
