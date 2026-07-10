class_name Jump 
extends State

@export var jump_force: float

func enter() -> void:
	entity.velocity.y = jump_force
	print("Entered Jump:" )

func update(delta: float) -> void:
	if entity.is_on_floor() and !Input.is_action_just_pressed("jump"):
		change_state.emit(self, "move")
		print("Left Jump:" )
