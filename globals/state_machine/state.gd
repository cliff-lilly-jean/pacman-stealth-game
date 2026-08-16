extends Node
class_name	State

signal change_state(active_state: State, new_state: String)

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func update(delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass

func handle_input(event: InputEvent) -> void:
	pass
