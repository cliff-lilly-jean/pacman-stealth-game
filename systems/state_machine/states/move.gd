class_name Move extends State

@export var speed : float = 10.0
@export var acceleration: float = 5.0
@export var friction: float = 0.5
@export var look_angle_speed : float = 10.0
@export var entity: RigidBody3D

var direction: Vector2

func _ready() -> void:
	entity.physics_material_override.friction = friction

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
	direction.normalized()
	
	if direction.length() > 0.1:
		entity.linear_velocity.x = move_toward(entity.linear_velocity.x, direction.x * speed, acceleration) 
		entity.linear_velocity.z = move_toward(entity.linear_velocity.z, direction.y * speed, acceleration)
	else:
		entity.linear_velocity.x = move_toward(entity.linear_velocity.x, direction.x * speed, friction) 
		entity.linear_velocity.z = move_toward(entity.linear_velocity.z, direction.y * speed, friction)

# Look Direction
	if direction.length() > 0.0:
		var look_angle = -direction.angle() + PI/2
		entity.model.rotation.y = rotate_toward(entity.model.rotation.y, look_angle, look_angle_speed * delta)
