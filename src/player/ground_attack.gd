extends CharacterState

@export var attack_1 : StringName
@export var attack_2 : StringName
@export var attack_3 : StringName
var attack_sequence : int

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	super()
	attack_sequence = player_stats.attack_sequence
	if attack_sequence == 1:
		character.animation_player.play(attack_1)
	elif attack_sequence == 2:
		character.animation_player.play(attack_2)
	elif attack_sequence == 3:
		character.animation_player.play(attack_3)
	attack_sequence = (attack_sequence % 3) + 1
	player_stats.attack_sequence = attack_sequence
	character.animation_player.animation_finished.connect(_on_animation_finished)
	print("attack ", attack_sequence)
	
	
func _exit() -> void:
	character.animation_player.animation_finished.disconnect(_on_animation_finished)

func _update(delta: float) -> void:
	pass

func _on_animation_finished(animation : StringName):
	dispatch("attack_finished")
