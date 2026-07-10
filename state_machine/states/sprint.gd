class_name Sprint
extends State

@export var sprint_speed: float
@export var sprint_acceleration: float

func enter() -> void:
	print("Entered Sprint:" )
	

func update(delta: float) -> void:
	
	if !Input.is_action_pressed("sprint"):
		change_state.emit(self, 'move')
		print("Left Sprint:" )

func physics_update(delta: float) -> void:
	apply_sprint(entity.input_component.input_direction ,delta)


func apply_sprint(input: Vector2, delta: float):
	var sprint_direction: Vector3 = Vector3(input.x, 0, input.y)
	
	entity.velocity.x = move_toward(entity.velocity.x, sprint_direction.x * sprint_speed,  sprint_acceleration * delta)
	entity.velocity.z = move_toward(entity.velocity.z, sprint_direction.z * sprint_speed, sprint_acceleration * delta)
