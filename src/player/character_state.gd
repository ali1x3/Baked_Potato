class_name CharacterState
extends LimboState

@export var animation_name : StringName

var character : CharacterBody2D
var player_stats : PlayerStats

func _enter() -> void:
	character = agent as CharacterBody2D
	player_stats = character.player_stats
	agent.animations.play(animation_name)


func _physics_process(delta: float) -> void:
	player_stats.coyote_timer -= delta
	
func jump():
	character.velocity.y = player_stats.jump_speed
	print("jumped")
