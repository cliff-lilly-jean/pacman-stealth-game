class_name CameraController extends Node3D

@export var spring_arm : SpringArm3D
@export_range(15.0, 25.0, 1.0) var spring_arm_length : float = 4.0

@export var model: Node3D

@export var pitch_speed : float = 0.2
@export var yaw_speed :  float = 0.5
@export var look_angle_speed : float  = 10.0

@export var joystick_sensitivity :  float = 8.0
@export var mouse_sensitivity : float = 0.5

@export var min_pitch_clamp : float = -0.8
@export  var max_pitch_clamp : float = -0.5


func _ready() -> void:
	spring_arm.spring_length = spring_arm_length
	

		
func rotate_from_vector(vector: Vector2, delta: float) -> void:
	spring_arm.rotation.y -= vector.x * yaw_speed * delta
	spring_arm.rotation.x += vector.y * pitch_speed * delta
	

	# clamp the max and min pitch
	spring_arm.rotation.x = clampf(spring_arm.rotation.x, min_pitch_clamp, max_pitch_clamp)
