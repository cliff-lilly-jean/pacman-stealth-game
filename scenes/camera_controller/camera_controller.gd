class_name CameraController extends SpringArm3D

const max_look_down_angle: float = deg_to_rad(-1)
const max_look_up_angle: float = deg_to_rad(-45)

@export var mouse_sensitivity: float
@export var joystick_sensitivity: float
@export var length: float

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	spring_length = length
	
func _process(delta: float) -> void:
	joystick_rotation(delta)	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * mouse_sensitivity
		rotation.x -= event.relative.y * mouse_sensitivity
		
		rotation.x = clampf(rotation.x, max_look_up_angle, max_look_down_angle)

func joystick_rotation(delta: float) -> void:
	var joystick_direction = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	
	rotation.y -= joystick_direction.x * joystick_sensitivity * delta
	rotation.x -= joystick_direction.y * joystick_sensitivity * delta
		

	rotation.x = clampf(rotation.x, max_look_up_angle, max_look_down_angle)
