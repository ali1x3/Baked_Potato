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
	add_transition(states["air"], states["dodge"], "airdodge")
	add_transition(states["ground"], states["dodge"], "dodge")
	add_transition(states["dodge"], states["ground"], "end_dodge")
	add_transition(states["dodge"], states["air"], "end_airdodge")
	add_transition(states["ground"], states["groundattack"], "attack")
	add_transition(states["groundattack"], states["ground"], "attack_finished")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
