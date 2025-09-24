extends CharacterBody2D

@export var player_stats : PlayerStats
# constants
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const COYOTE_TIME = 0.10 # grace period that you can perform a normal jump after a ledge
const BUFFER_TIME = 0.10

# booleans
var double_jumped = false

var attack_string = 0
var current_speed = SPEED
var dodge_multiplier = 3.0


# timers
var coyote_timer = COYOTE_TIME
var buffer_timer = BUFFER_TIME

# gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_vector = Vector2(0.0, gravity)
@export var animations: AnimatedSprite2D

# player state
enum PlayerState { ATTACK, DODGE, GROUND_MOVE, AIR, IDLE }
var state = PlayerState.IDLE


func _ready() -> void:
	animations.animation_finished.connect(animation_finished)


func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		transform.x = Vector2(1.0, 0.0)
	elif velocity.x < 0:
		transform.x = Vector2(-1.0, 0.0)
		
	apply_physics(delta)
	move_and_slide()


func animation_finished():
	var animation = animations.animation
	if animation == "dodge":
		reset_dodge()
	state = PlayerState.IDLE

func handle_timers_helpers(delta: float):
	if is_on_floor():
		coyote_timer = COYOTE_TIME
		double_jumped = false
	else:
		coyote_timer -= delta

func handle_inputs():
	attack_listener()
	dodge_listener()

func handle_state():
	pass
	

func handle_state_effects():
	pass


func apply_physics(delta: float):
	if animations.animation == "dodge":
		velocity.y = 0
		return
	if not is_on_floor():
		if velocity.y > 0:
			velocity += gravity_vector * delta
		else:
			velocity += gravity_vector * 1.3 * delta


func animation_update() -> void:
	match state:
		PlayerState.DODGE:
			print("dodge")
			animations.play("dodge")
			return
		PlayerState.ATTACK:
			print("attack")
			attack_listener()
			return
			
	
	if animations.animation in ["attack_string1", "attack_string2", "attack_string3", "dodge"]:
		if animations.is_playing():
			return
	
	match state:
		PlayerState.IDLE:
			animations.play("idle")
		PlayerState.GROUND_MOVE:
			animations.play("run")
		PlayerState.AIR:
			# falling animation here
			pass
			
			
func dodge_listener() -> void:
	if Input.is_action_just_pressed("dodge"):
		current_speed *= dodge_multiplier
		state = PlayerState.DODGE


func attack_listener() -> void:
	if Input.is_action_just_pressed("attack"):
		reset_dodge()
		attack_string_handler()


func attack_string_handler() -> void:
	if attack_string == 0:
		animations.play("attack_string1")
		print("attack string 1")
	elif attack_string == 1:
		animations.play("attack_string2")
		print("attack string 2")
	elif attack_string == 2:
		animations.play("attack_string3")
		print("attack string 3")
	attack_string = (attack_string + 1) % 3


func reset_dodge():
	current_speed = SPEED
	state = PlayerState.IDLE
