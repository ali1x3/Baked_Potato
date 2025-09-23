extends CharacterBody2D

# constants
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const COYOTE_TIME = 0.10 # grace period that you can perform a normal jump after a ledge
const BUFFER_TIME = 0.10
const FRICTION = 100.0

# booleans
var DOUBLE_JUMPED = false
var is_attacking = false
var attack_string = 0

# timers
var coyote_timer = COYOTE_TIME
var buffer_timer = BUFFER_TIME

# gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_vector = Vector2(0.0, 980.0)
@onready var animations: AnimatedSprite2D = $animations

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		coyote_timer -= delta
		if velocity.y > 0:
			velocity += gravity_vector * delta
		else :
			velocity += gravity_vector * 1.3 * delta
	else:
		coyote_timer = COYOTE_TIME
		DOUBLE_JUMPED = false

	# Handle jump.
	var taking_action = is_attacking
	
	if not taking_action:
		run_listener()
		attack_listener(delta)
		jump_listener()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	move_and_slide()

func jump_listener() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or coyote_timer > 0.0:
			velocity.y = JUMP_VELOCITY
		elif not DOUBLE_JUMPED:
			velocity.y = JUMP_VELOCITY
			DOUBLE_JUMPED = true
	if Input.is_action_just_released("jump"):
		velocity.y *= 0.3

func run_listener() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			animations.flip_h = true
		else:
			animations.flip_h = false
		animations.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animations.play("idle")

func attack_listener(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		gravity_vector *= 0.03
		velocity.y = 0
		velocity.x *= 0.05
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		attack_string_handler()
		animations.animation_finished.connect(attack_finished)


func attack_string_handler() -> void:
	if attack_string == 0:
		animations.play("attack_string1")
		print("attack string 1")
		attack_string += 1
	elif attack_string == 1:
		animations.play("attack_string2")
		print("attack string 2")
		attack_string += 1
	elif attack_string == 2:
		animations.play("attack_string3")
		print("attack string 3")
		attack_string = 0



func attack_finished() -> void:
	is_attacking = false
	gravity_vector = get_gravity()
	
