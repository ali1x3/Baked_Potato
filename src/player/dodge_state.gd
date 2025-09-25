extends CharacterState

func _enter() -> void:
	super()
	blackboard.set_var(BlackboardNames.allow_dodge_var, false)
	player_stats.dodge_cooldown_timer = player_stats.DODGE_COOLDOWN
	var direction : Vector2 = blackboard.get_var(BlackboardNames.direction_var)
	if not is_zero_approx(direction.x):
		character.velocity.x = direction.x * player_stats.DODGE_SPEED
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, player_stats.DODGE_SPEED)
	
func _update(delta: float) -> void:
	super(delta)
	
	player_stats.dodge_timer -= delta
	if player_stats.dodge_timer <= 0:
		player_stats.dodge_timer = player_stats.DODGE_TIME
		if character.is_on_floor():
			dispatch("end_dodge")
		else:
			dispatch("end_airdodge")
	character.move_and_slide()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
