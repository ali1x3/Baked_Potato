extends CharacterBody2D

@export var player_stats : PlayerStats
@export var animations: AnimatedSprite2D
@onready var state_label: Label = $StateLabel

func _physics_process(delta: float) -> void:
	pass
