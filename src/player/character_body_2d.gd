extends CharacterBody2D

@export var player_stats : PlayerStats

# gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_vector = Vector2(0.0, gravity)
@export var animations: AnimatedSprite2D

# player state



func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		transform.x = Vector2(1.0, 0.0)
	elif velocity.x < 0:
		transform.x = Vector2(-1.0, 0.0)
		
	apply_physics(delta)
	move_and_slide()





func apply_physics(delta: float):
	if animations.animation == "dodge":
		velocity.y = 0
		return
	if not is_on_floor():
		if velocity.y > 0:
			velocity += gravity_vector * delta
		else:
			velocity += gravity_vector * 1.3 * delta
