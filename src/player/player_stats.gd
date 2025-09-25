class_name PlayerStats
extends Resource

@export var run_speed : float = 300.0
@export var max_air_speed : float = 180.0
@export var air_acceleration : float = 100.0
@export var jump_speed : float = -400.0
const COYOTE_TIME : float = 0.15
const BUFFER_TIME : float = 0.10
@export var coyote_timer : float = COYOTE_TIME # grace period that you can perform a normal jump after a ledge
@export var buffer_timer : float = BUFFER_TIME
@export var jumped : bool = false
@export var double_jumped : bool = false
const DODGE_TIME : float = 0.2
const DODGE_COOLDOWN : float = 0.6
const DODGE_SPEED : float = 500.0
@export var dodge_timer : float = 0.2
@export var dodge_cooldown_timer : float = 0.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_vector = Vector2(0.0, gravity)
