extends CharacterBody2D

@export var player_stats : PlayerStats

# gravity

@export var animations: AnimatedSprite2D

# player state



func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		transform.x = Vector2(1.0, 0.0)
	elif velocity.x < 0:
		transform.x = Vector2(-1.0, 0.0)
		
