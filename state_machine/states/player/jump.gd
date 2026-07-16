class_name Jump 
extends State

@export var jump_force: float

func enter() -> void:
	if entity is Player:
		if entity.input_manager.jump_release_input and entity.velocity.y > 0.0:
			entity.velocity.y *= -0.45
	
			entity.velocity.y = jump_force

func update(delta: float) -> void:
	if entity is Player:
		if entity.is_on_floor() and !entity.input_manager.jump_input:
			change_state.emit(self, "move")
			
