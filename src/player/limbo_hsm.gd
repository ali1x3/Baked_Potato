extends LimboHSM

@export var character : CharacterBody2D
@export var states : Dictionary[String, LimboState]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_binding_setup()
	initialize(character)
	set_active(true)

func _binding_setup():
	add_transition(states["ground"], states["air"], "midair")
	add_transition(states["air"], states["ground"], "land")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
