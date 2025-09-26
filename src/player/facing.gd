extends Node2D

@export var character : CharacterBody2D
@onready var dodge_fx: AnimatedSprite2D = $"../../dodge_fx"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if character.velocity.x > 0:
		transform.x = Vector2(1.0, 0.0)
		dodge_fx.transform.x = Vector2(1.0, 0.0)
	elif character.velocity.x < 0:
		transform.x = Vector2(-1.0, 0.0)
		dodge_fx.transform.x = Vector2(-1.0, 0.0)
		
