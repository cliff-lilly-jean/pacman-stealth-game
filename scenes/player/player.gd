class_name Player extends CharacterBody3D

@export var roll_speed: float
@export var boost_speed: float
@export var acceleration: float
@export var spring_length: float

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var direction: Vector3

func _ready() -> void:
	spring_arm.spring_length = spring_length


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.001) 
		
		spring_arm.rotate_x(-event.relative.y * 0.001)
		spring_arm.rotation.x = clampf(spring_arm.rotation.x, -1, 30)
	

func _physics_process(delta: float) -> void:
	roll(delta)
	move_and_slide()

func roll(delta: float) -> void:
	var input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")
	var speed :  float = boost_speed if Input.is_action_pressed("dash") else roll_speed
	var desired_velocity: Vector3 = Vector3(input_direction.x, 0, input_direction.y)
	
	if input_direction.length() >= 0.1:
		velocity.x = move_toward(velocity.x, desired_velocity.x * speed * acceleration, delta)
		velocity.z = move_toward(velocity.z, desired_velocity.z * speed * acceleration, delta)
	else:
		velocity.x = move_toward(0, desired_velocity.x * speed * acceleration, delta)
		velocity.z = move_toward(0, desired_velocity.z * speed * acceleration, delta)
