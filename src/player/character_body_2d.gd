extends CharacterBody2D

@export var player_stats : PlayerStats
@export var animations: AnimatedSprite2D
@export var animation_player : AnimationPlayer
@export var dodge_fx: AnimatedSprite2D
@export var jump_fx: AnimatedSprite2D
@onready var state_label: Label = $StateLabel

func _physics_process(delta: float) -> void:
	pass
