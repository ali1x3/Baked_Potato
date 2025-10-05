class_name PlayerInput
extends Node


@export var player_actions : PlayerActions
@export var limbo_hsm : LimboHSM

var blackboard : Blackboard
var input_direction : Vector2
var jump : bool
var jump_released : bool = true
var dodge : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	blackboard = limbo_hsm.blackboard
	blackboard.bind_var_to_property(BlackboardNames.direction_var, self, "input_direction", true)
	blackboard.bind_var_to_property(BlackboardNames.jump_var, self, "jump", true)
	blackboard.bind_var_to_property(BlackboardNames.dodge_var, self, "dodge", true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	input_direction = Input.get_vector(
		player_actions.move_left,
		player_actions.move_right,
		player_actions.move_up,
		player_actions.move_down
	)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(player_actions.jump):
		jump = true
		
	elif event.is_action_released(player_actions.jump):
		jump = false
		blackboard.set_var(BlackboardNames.allow_jump_var, true)
		
	elif event.is_action_pressed(player_actions.dodge):
		dodge = true
		blackboard.set_var(BlackboardNames.allow_dodge_var, false)

	elif event.is_action_released(player_actions.dodge):
		dodge = false
