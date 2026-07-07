class_name Player extends CharacterBody3D

const max_look_down: float = deg_to_rad(10)
const max_look_up: float = deg_to_rad(-45)

@export_group("Movement")
@export var roll_speed: float
@export var boost_speed: float
@export var acceleration: float


@export_group("Camera")
@export var mouse_sensitivity: float
@export var joystick_sensitivity: float
@export var spring_length: float

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var direction: Vector3

func _ready() -> void:
	spring_arm.spring_length = spring_length
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity) 
		
		spring_arm.rotate_x(-event.relative.y * mouse_sensitivity)
		spring_arm.rotation.x = clampf(spring_arm.rotation.x, max_look_up, max_look_down)

func _process(delta: float) -> void:
	joystick_rotation(delta)

func _physics_process(delta: float) -> void:
	roll(delta)
	
	move_and_slide()

func roll(delta: float) -> void:
	var input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")
	var speed :  float = boost_speed if Input.is_action_pressed("dash") else roll_speed
	var desired_velocity: Vector3 = Vector3(input_direction.x, 0, input_direction.y) * speed
	
	if input_direction.length() >= 0.1:
		velocity.x = move_toward(velocity.x, desired_velocity.x,  acceleration * delta)
		velocity.z = move_toward(velocity.z, desired_velocity.z, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * delta)
		velocity.z = move_toward(velocity.z, 0, acceleration * delta)

func joystick_rotation(delta: float) -> void:
	var joystick_direction = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	
	rotate_y(-joystick_direction.x * joystick_sensitivity * delta)
		
	spring_arm.rotation.x -= -joystick_direction.y * joystick_sensitivity * delta
	spring_arm.rotation.x = clampf(spring_arm.rotation.x, max_look_up, max_look_down)
