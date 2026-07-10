class_name Dash 
extends State

@export var dash_speed: float

func enter() -> void:
	print("Entered Dash:" )

func update(delta) -> void:
	if !Input.is_action_just_pressed("dash"):
		change_state.emit(self, 'move')
		print("Left Dash:" )
