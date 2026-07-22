class_name CameraController extends SpringArm3D

const max_look_down_angle: float = deg_to_rad(-10)
const max_look_up_angle: float = deg_to_rad(-65)

@export var mouse_sensitivity: float
@export var joystick_sensitivity: float
@export var length: float
@export var entity: Player

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	spring_length = length

func _physics_process(delta: float) -> void:
	joystick_rotation(delta)
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		entity.rotate_y(-event.relative.x * mouse_sensitivity)
		
		rotate_x(-event.relative.y * mouse_sensitivity) 
		rotation.x = clampf(rotation.x, max_look_up_angle, max_look_down_angle)

func joystick_rotation(delta: float) -> void:
	var joystick_direction = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	
	entity.rotate_y(-joystick_direction.x * joystick_sensitivity * delta)
	
	rotation.x -= joystick_direction.y * joystick_sensitivity * delta
	rotation.x = clampf(rotation.x, max_look_up_angle, max_look_down_angle)
