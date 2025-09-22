extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const COYOTE_TIME = 0.10 # grace period that you can perform a normal jump after a ledge
var DOUBLE_JUMPED = false
var is_attacking = false
var coyote_timer = COYOTE_TIME
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_vector = Vector2(0.0, 980.0)
@onready var animations: AnimatedSprite2D = $animations

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		coyote_timer -= delta
		velocity += gravity_vector * delta
	else:
		coyote_timer = COYOTE_TIME
		DOUBLE_JUMPED = false

	# Handle jump.
	var taking_action = is_attacking
	
	if not taking_action:
		run_listener()
		attack_listener()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	jump_listener()
	move_and_slide()

func jump_listener() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or coyote_timer > 0.0:
			velocity.y = JUMP_VELOCITY
		elif not DOUBLE_JUMPED:
			velocity.y = JUMP_VELOCITY
			DOUBLE_JUMPED = true

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

func attack_listener() -> void:
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		gravity_vector *= 0.5
		velocity.y *= 0.2
		velocity.x *= 0.4
		animations.play("attack")
		animations.animation_finished.connect(attack_finished)

func attack_finished() -> void:
	is_attacking = false
	gravity_vector = get_gravity()
