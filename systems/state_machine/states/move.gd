class_name Move extends State

@export var speed : float = 8.0
@export var look_angle_speed : float = 10.0
@export var body: RigidBody3D

var direction: Vector2

func enter() -> void:
	if body == null:
		print_debug("The Move node needs a body assigned to it")
		return
		
func physics_update(delta: float) -> void:
	
	if body.input_controller.jump_pressed and body.ground_detection.is_grounded():
		change_state.emit(self, "jump")
		return
		
	if body.input_controller.dash_pressed and body.ground_detection.is_grounded():
		change_state.emit(self, "dash")
		return
	
	# Directional Movement	
	direction = body.input_controller.move_direction.rotated(-body.camera_controller.spring_arm.global_rotation.y)
	
	body.linear_velocity.x = direction.x * speed
	body.linear_velocity.z = direction.y * speed
	


# Look Direction
	if direction.length() > 0.0:
		var look_angle = -direction.angle() + PI/2
		body.model.rotation.y = rotate_toward(body.model.rotation.y, look_angle, look_angle_speed * delta)
