class_name Jump extends State

@export var force : float = 20.0
@export var body: RigidBody3D

func enter() -> void:
	if body == null:
		print_debug("The Jump node needs a body assigned to it")
		return
		
	body.linear_velocity.y = force
	
	
func physics_update(delta: float) -> void:
	
	if body.ground_detection_system.is_grounded() and !body.input_system.jump_pressed:
		change_state.emit(self, "move")
		return
