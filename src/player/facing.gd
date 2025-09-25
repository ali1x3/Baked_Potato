extends Node2D

@export var character : CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if character.velocity.x > 0:
		transform.x = Vector2(1.0, 0.0)
	elif character.velocity.x < 0:
		transform.x = Vector2(-1.0, 0.0)
		
