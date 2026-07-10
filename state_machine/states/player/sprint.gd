class_name Sprint
extends State

@export var sprint_speed: float
@export var sprint_acceleration: float

func enter() -> void:
	print("Entered Sprint:" )
	

func update(delta: float) -> void:
	if entity is Player:
		if entity.is_on_floor() and entity.input_component.jump_input:
			change_state.emit(self, 'jump')
			print("Left Sprint:" )
			
		if entity.is_on_floor() and entity.input_component.dash_input:
			change_state.emit(self, "dash")
			print("Left Sprint:" )
		
		if !entity.input_component.sprint_input:
			change_state.emit(self, 'move')
			print("Left Sprint:" )

func physics_update(delta: float) -> void:
	apply_sprint(entity.input_component.input_direction ,delta)


func apply_sprint(input: Vector2, delta: float):
	var sprint_direction: Vector3 = Vector3(input.x, 0, input.y)
	
	entity.velocity.x = move_toward(entity.velocity.x, sprint_direction.x * sprint_speed,  sprint_acceleration * delta)
	entity.velocity.z = move_toward(entity.velocity.z, sprint_direction.z * sprint_speed, sprint_acceleration * delta)
