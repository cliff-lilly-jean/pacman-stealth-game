class_name Dash 
extends State

@export var dash_speed: float

func enter() -> void:
	print("Entered Dash:" )

func update(delta) -> void:
	
	if entity is Player:
		if entity.is_on_floor() and entity.input_component.jump_input:
			change_state.emit(self, 'jump')
			print("Left Move:" )
			
		if entity.is_on_floor() and entity.input_component.sprint_input:
			change_state.emit(self, "sprint")
			print("Left Move:" )
		
		if !entity.input_component.dash_input:
			change_state.emit(self, 'move')
			print("Left Dash:" )
