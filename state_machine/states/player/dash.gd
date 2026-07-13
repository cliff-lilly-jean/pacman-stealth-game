class_name Dash 
extends State

@export var dash_speed: float

func enter() -> void:

	if entity is Player:
		var dash_direction = entity.input_manager.input_direction
		entity.velocity.x = move_toward(entity.velocity.x, dash_direction.x * dash_speed, 10)
		entity.velocity.z = move_toward(entity.velocity.z, dash_direction.y * dash_speed, 10)
		print("Dash: ", entity.input_manager.dash_input)

func update(delta) -> void:
	
	if entity is Player:
		if entity.is_on_floor() and entity.input_manager.jump_input:
			change_state.emit(self, 'jump')
				
		if entity.is_on_floor() and entity.input_manager.sprint_input:
			change_state.emit(self, "sprint")
		
		if !entity.input_manager.dash_input:
			change_state.emit(self, 'move')
