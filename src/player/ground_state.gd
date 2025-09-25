extends CharacterState


func _enter() -> void:
	super()
	player_stats.double_jumped = false
	player_stats.jumped = false
	blackboard.set_var(BlackboardNames.allow_jump_var, true)

func _update(delta: float) -> void:
	super(delta)
	if character.is_on_floor():
		player_stats.coyote_timer = player_stats.COYOTE_TIME

	var velocity : Vector2 = move()
	
	if Vector2.ZERO.is_equal_approx(velocity):
		agent.animations.play("idle")
	else:
		agent.animations.play("run")
	
	if not character.is_on_floor():
		dispatch("midair")
	
	if blackboard.get_var(BlackboardNames.dodge_var) && blackboard.get_var(BlackboardNames.allow_dodge_var):
		dispatch("dodge")
		
		
	if blackboard.get_var(BlackboardNames.jump_var) && blackboard.get_var(BlackboardNames.allow_jump_var, true):
		if character.is_on_floor(): 
			jump()
			player_stats.jumped = true
			blackboard.set_var(BlackboardNames.allow_jump_var, false)


func move() -> Vector2:
	var direction : Vector2 = blackboard.get_var(BlackboardNames.direction_var)
	
	if not is_zero_approx(direction.x):
		character.velocity.x = direction.x * player_stats.run_speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, player_stats.run_speed)
	
	character.move_and_slide()
	return character.velocity
