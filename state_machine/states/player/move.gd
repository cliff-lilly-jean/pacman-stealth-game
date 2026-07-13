class_name Move
extends State

@export var move_speed: float
@export var acceleration: float

func enter() -> void:
	pass

func update(delta: float) -> void:
	if entity is Player:
		if entity.is_on_floor() and entity.input_manager.jump():
			change_state.emit(self, 'jump')
			
		if entity.is_on_floor() and entity.input_manager.dash():
			change_state.emit(self, "dash")
			
		if entity.is_on_floor() and entity.input_manager.sprint():
			change_state.emit(self, "sprint")
	
func physics_update(delta: float) -> void:
	apply_move(entity.input_manager.input_direction, entity.spring_arm, delta)
	pass


func apply_move(input: Vector2, camera: Node3D, delta: float) -> void:
	var direction = input.rotated(-camera.global_rotation.y).normalized()
	var desired_velocity: Vector3 = Vector3(direction.x, 0, direction.y) * move_speed
	
	if entity is Player:
		if input.length() > 0.1:
			var target_angle: float = atan2(desired_velocity.x, desired_velocity.z)
		
			entity.mesh.global_rotation.y = lerp_angle(
				entity.mesh.global_rotation.y,
				target_angle,
				10 * delta
			)
	
		if input.length() >= 0.1:
			entity.velocity.x = move_toward(entity.velocity.x, desired_velocity.x,  acceleration * delta)
			entity.velocity.z = move_toward(entity.velocity.z, desired_velocity.z, acceleration * delta)
		else:
			entity.velocity.x = move_toward(entity.velocity.x, 0, acceleration * delta)
			entity.velocity.z = move_toward(entity.velocity.z, 0, acceleration * delta)
	
