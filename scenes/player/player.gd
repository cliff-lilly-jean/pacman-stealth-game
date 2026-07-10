class_name Player extends CharacterBody3D

const max_look_down_angle: float = deg_to_rad(-1)
const max_look_up_angle: float = deg_to_rad(-65)

@export_group("Camera")
@export var mouse_sensitivity: float
@export var joystick_sensitivity: float
@export var spring_length: float

@export_group("Gravity")
@export var gravity: float

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var stamina: StaminaComponent = %StaminaComponent
@onready var input_component: InputComponent = %InputComponent

var direction: Vector3

func _ready() -> void:
	spring_arm.spring_length = spring_length
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity) 
		
		spring_arm.rotate_x(-event.relative.y * mouse_sensitivity)
		spring_arm.rotation.x = clampf(spring_arm.rotation.x, max_look_up_angle, max_look_down_angle)

func _process(delta: float) -> void:
	joystick_rotation(delta)

func _physics_process(delta: float) -> void:
	input_component.update(delta)
	
	
	dash(delta)
	apply_gravity(delta)
	move_and_slide()


func joystick_rotation(delta: float) -> void:
	var joystick_direction = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	
	rotate_y(-joystick_direction.x * joystick_sensitivity * delta)
		
	spring_arm.rotation.x -= -joystick_direction.y * joystick_sensitivity * delta
	spring_arm.rotation.x = clampf(spring_arm.rotation.x, max_look_up_angle, max_look_down_angle)

func dash(delta: float) -> void:
	if is_on_floor() and Input.is_action_just_pressed("dash"):
	
		print("Dash: , ", velocity)
		stamina.use(5)

func apply_gravity(delta: float) -> void:
	velocity.y -= gravity
