class_name Player extends CharacterBody3D

@export_group("Movement")
@export var roll_speed: float
@export var boost_speed: float
@export var acceleration: float


@export_group("Camera")
@export var mouse_sensitivity: float
@export var joystick_sensitivity: float
@export var min_vertical_clamp: float
@export var max_vertical_clamp: float
@export var spring_length: float

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var direction: Vector3

func _ready() -> void:
	spring_arm.spring_length = spring_length
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.001) 
		
		spring_arm.rotate_x(-event.relative.y * mouse_sensitivity)
		spring_arm.rotation.x = clampf(spring_arm.rotation.x, min_vertical_clamp, max_vertical_clamp)
	

func _physics_process(delta: float) -> void:
	roll(delta)
	joystick_rotation()
	move_and_slide()

func roll(delta: float) -> void:
	var input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")
	var speed :  float = boost_speed if Input.is_action_pressed("dash") else roll_speed
	var desired_velocity: Vector3 = Vector3(input_direction.x, 0, input_direction.y)
	
	if input_direction.length() >= 0.1:
		velocity.x = move_toward(velocity.x, desired_velocity.x * speed,  acceleration * delta)
		velocity.z = move_toward(velocity.z, desired_velocity.z * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * delta)
		velocity.z = move_toward(velocity.z, 0, acceleration * delta)

func joystick_rotation() -> void:
	var joystick_direction = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	
	spring_arm.rotation.y -= joystick_direction.x * joystick_sensitivity
		
	spring_arm.rotation.x -= joystick_direction.y * joystick_sensitivity
	spring_arm.rotation.x = clampf(spring_arm.rotation.x, min_vertical_clamp, max_vertical_clamp)
