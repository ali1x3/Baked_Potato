extends CharacterState


func _update(delta: float) -> void:
	super(delta)
	var _velocity : Vector2 = air_move()
	if character.is_on_floor():
		dispatch("land")
	
	# reading from the blackboard if a dodge input was detected, and if the character is allowed to dodge
	if blackboard.get_var(BlackboardNames.dodge_var) && blackboard.get_var(BlackboardNames.allow_dodge_var, true):
		dispatch("airdodge")
	
	# same thing as above but for coyote and double jump
	if blackboard.get_var(BlackboardNames.jump_var) && blackboard.get_var(BlackboardNames.allow_jump_var, true):
		if character.is_on_floor(): 
			jump()
			player_stats.jumped = true
			blackboard.set_var(BlackboardNames.allow_jump_var, false)
			
		elif player_stats.coyote_timer >= 0 and (not player_stats.jumped):
			player_stats.jumped = true
			print("coyote")
			jump()
			blackboard.set_var(BlackboardNames.allow_jump_var, false)
			
		elif not player_stats.double_jumped:
			jump()
			player_stats.double_jumped = true

func air_move() -> Vector2:
	var direction : Vector2 = blackboard.get_var(BlackboardNames.direction_var)
	
	# this gives the illusion of air friction
	if direction.x > 0:
		var attempeted_velocity_x = min(
			player_stats.max_air_speed,
			character.velocity.x + player_stats.air_acceleration
		)
		character.velocity.x = max(
			character.velocity.x,
			attempeted_velocity_x
		)
	elif direction.x < 0:
		var attempeted_velocity_x = max(
			-player_stats.max_air_speed,
			character.velocity.x - player_stats.air_acceleration
		)
		character.velocity.x = min(
			character.velocity.x,
			attempeted_velocity_x
		)
	
	
	character.move_and_slide()
	return character.velocity


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
