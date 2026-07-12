class_name Dash 
extends State

@export var dash_speed: float

func enter() -> void:
	print("Entered Dash:" )

	if entity is Player:
		var dash_direction = entity.input_component.input_direction
		entity.velocity.x = move_toward(entity.velocity.x, dash_direction.x * dash_speed, 10)
		entity.velocity.z = move_toward(entity.velocity.z, dash_direction.y * dash_speed, 10)

func update(delta) -> void:
	
	if entity is Player:
		if entity.is_on_floor() and entity.input_component.jump_input:
			change_state.emit(self, 'jump')
			print("Left Dash:" )
			
		if entity.is_on_floor() and entity.input_component.sprint_input:
			change_state.emit(self, "sprint")
			print("Left Dash:" )
		
		if !entity.input_component.dash_input:
			change_state.emit(self, 'move')
			print("Left Dash:" )
