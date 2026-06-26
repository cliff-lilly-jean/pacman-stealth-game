class_name Player extends RigidBody3D

@export_group("Controllers")
@export var input_controller: InputController
@export var ground_detection: GroundDetection
@export var camera_controller: CameraController

@export var model: Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	## Inputs
	input_controller.process_inputs()
	
	## Camera Rotation
	camera_controller.rotate_from_vector(input_controller.joystick_direction * camera_controller.joystick_sensitivity, delta)
	camera_controller.rotate_from_vector(input_controller.mouse_direction * camera_controller.mouse_sensitivity, delta)
	
	## Zero out all the input vectors to remove any unwanted movement and rotations
	input_controller.mouse_direction = Vector2.ZERO
	input_controller.joystick_direction = Vector2.ZERO
	
	
