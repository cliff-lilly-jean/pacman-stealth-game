class_name Move extends State

@export var speed : float = 1200.0
@export var acceleration: float = 2.0
@export var friction: float = 0.01
@export var look_angle_speed : float = 10.0
@export var entity: RigidBody3D

var direction: Vector2

func enter() -> void:
	if entity == null:
		print_debug("The Move node needs a entity assigned to it")
		return
		
func physics_update(delta: float) -> void:
	
	if entity.input_controller.jump_pressed and entity.ground_detection.is_grounded():
		change_state.emit(self, "jump")
		return
		
	if entity.input_controller.dash_pressed and entity.ground_detection.is_grounded():
		change_state.emit(self, "dash")
		return
	
	# Directional Movement	
	direction = entity.input_controller.move_direction.rotated(-entity.camera_controller.spring_arm.global_rotation.y)
	
	entity.linear_velocity.x = direction.x 
	entity.linear_velocity.z = direction.y  
		
	if direction.length() > 0.1:
		
		entity.linear_velocity.move_toward(Vector3(direction.x, 0, direction.y * speed) , acceleration)
	else:
		
		entity.linear_velocity.move_toward(Vector3.ZERO, friction)


# Look Direction
	if direction.length() > 0.0:
		var look_angle = -direction.angle() + PI/2
		entity.model.rotation.y = rotate_toward(entity.model.rotation.y, look_angle, look_angle_speed * delta)
