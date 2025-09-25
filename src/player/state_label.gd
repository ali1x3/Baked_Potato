extends Label

@export var character : CharacterBody2D
var state : String = " "
var velocity : String
var dodge_cd : String
# this just shows what the current state of the character is in text
@export var limbo_hsm : LimboHSM :
	set(value):
		if limbo_hsm != null:
			limbo_hsm.active_state_changed.disconnect(_on_active_state_changed)
		
		limbo_hsm = value
		
		if limbo_hsm != null:
			var current_state = limbo_hsm.get_active_state()
			if current_state != null:
				text = current_state.name
			limbo_hsm.active_state_changed.connect(_on_active_state_changed)

func _on_active_state_changed(current: LimboState, _previous : LimboState):
	state = current.name

func _process(delta: float) -> void:
	velocity = str(character.velocity)
	dodge_cd = str("%.2f" % limbo_hsm.agent.player_stats.dodge_cooldown_timer)
	text = velocity + "\n" + dodge_cd + "\n" + state
