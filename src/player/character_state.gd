class_name CharacterState
extends LimboState

@export var animation_name : StringName

var character : CharacterBody2D
var player_stats : PlayerStats

func _enter() -> void:
	character = agent as CharacterBody2D
	player_stats = character.player_stats
	agent.animations.play(animation_name)


func _update(delta: float) -> void:
	player_stats.coyote_timer -= delta
	player_stats.dodge_cooldown_timer -= delta
	if player_stats.dodge_cooldown_timer <= 0:
		player_stats.dodge_cooldown_timer = 0 # this is here for display purposes
		blackboard.set_var(BlackboardNames.allow_dodge_var, true)
		
	apply_physics(delta)
	character.move_and_slide()


func jump():
	character.velocity.y = player_stats.jump_speed
	print("jumped")

func apply_physics(delta: float):
	if character.animations.animation in ["dodge", "airdodge"]:
		character.velocity.y = 0
		return
	if not character.is_on_floor():
		if character.velocity.y > 0:
			character.velocity += player_stats.gravity_vector * delta
		else:
			character.velocity += player_stats.gravity_vector * 1.5 * delta
