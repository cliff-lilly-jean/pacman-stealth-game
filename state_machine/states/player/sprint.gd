class_name Sprint
extends State

@export var sprint_speed: float
@export var sprint_acceleration: float

func enter() -> void:
	pass
	

func update(delta: float) -> void:
	if entity is Player:
		if entity.is_on_floor() and entity.input_manager.jump_input:
			change_state.emit(self, 'jump')
			
		if entity.is_on_floor() and entity.input_manager.dash_input:
			change_state.emit(self, "dash")
		
		if !entity.input_manager.sprint_input:
			change_state.emit(self, 'move')

func physics_update(delta: float) -> void:
	apply_sprint(entity.input_manager.input_direction ,delta)
	if entity is Player:
		print("Sprint: ", entity.input_manager.sprint_input)


func apply_sprint(input: Vector2, delta: float):
	var sprint_direction: Vector3 = Vector3(input.x, 0, input.y)
	
	entity.velocity.x = move_toward(entity.velocity.x, sprint_direction.x * sprint_speed,  sprint_acceleration * delta)
	entity.velocity.z = move_toward(entity.velocity.z, sprint_direction.z * sprint_speed, sprint_acceleration * delta)
