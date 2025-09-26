extends CharacterState

func _enter() -> void:
	super()
	if character.velocity.x == 0:
		agent.animations.play("spotdodge")
	elif character.is_on_floor():
		agent.animations.play("dodge")
	else :
		agent.animations.play("airdodge")
	dash_fx()
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

func dash_fx() -> void:
	var dodge_fx: AnimatedSprite2D = $"../../../dodge_fx"
	if is_zero_approx(character.velocity.x):
		return
	
	
	if character.is_on_floor():
		dodge_fx.play("dodge_fx")
	else :
		dodge_fx.play("airdodge_fx")
	

		
	dodge_fx.global_position = character.global_position - Vector2(20, 20)
	if character.velocity.x > 0:
		dodge_fx.transform.x = Vector2(1.0, 0.0)
		dodge_fx.global_position = character.global_position - Vector2(15, 15)
	elif character.velocity.x < 0:
		dodge_fx.transform.x = Vector2(-1.0, 0.0)
		dodge_fx.global_position = character.global_position - Vector2(-15, 15)
		
