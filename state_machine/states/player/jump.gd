class_name Jump 
extends State

@export var jump_force: float

func enter() -> void:
	entity.velocity.y = jump_force
	print("Entered Jump:" )

func update(delta: float) -> void:
	if entity is Player:
		if entity.is_on_floor() and !entity.input_component.jump_input:
			print("Left Jump:" )
			change_state.emit(self, "move")
			
