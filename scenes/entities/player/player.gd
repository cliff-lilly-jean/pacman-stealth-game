class_name Player extends Entity

@export_group("Move")
@export var move_speed: float
@export var acceleration: float

@export_group("Sprint")
@export var sprint_speed: float
@export var sprint_acceleration: float

@export_group("Dash")
@export var dash_speed: float
@export var dash_acceleration: float

@export_group("Jump")
@export var jump_force: float
@export var jump_gravity: float
@export var fall_gravity: float

var input_direction: Vector2

@onready var stamina_component: StaminaComponent = $StaminaComponent

func _process(delta: float) -> void:
	input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")

func _physics_process(delta: float) -> void:
	move(input_direction, delta)
	sprint(input_direction, delta)
	dash(input_direction, delta)
	jump()
	apply_gravity(delta)
	move_and_slide()

func apply_gravity(delta: float) -> void:
	var gravity: float = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta
	
func move(input: Vector2, delta: float) -> void:
	var direction: Vector3 = Vector3(input.x, 0, input.y).normalized()
	var desired_velocity = transform.basis * direction * move_speed
	
	if input.length() > 0.1:
		var target_angle: float = atan2(desired_velocity.x, desired_velocity.z)
		mesh.global_rotation.y = lerp_angle(mesh.global_rotation.y, target_angle, 10 * delta)
	
	if input.length() >= 0.1:
		velocity.x = move_toward(velocity.x, desired_velocity.x,  acceleration * delta)
		velocity.z = move_toward(velocity.z, desired_velocity.z, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * delta)
		velocity.z = move_toward(velocity.z, 0, acceleration * delta)

func jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	if Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y *= -0.45

func sprint(input: Vector2, delta: float) -> void:
	if Input.is_action_pressed("sprint"):
		
		var sprint_direction: Vector3 = Vector3(input.x, 0, input.y)
		
		velocity.x = move_toward(velocity.x, sprint_direction.x * sprint_speed,  sprint_acceleration * delta)
		velocity.z = move_toward(velocity.z, sprint_direction.z * sprint_speed, sprint_acceleration * delta)

func dash(input: Vector2, delta: float) -> void:
	if Input.is_action_just_pressed("dash"):
		
		var dash_direction: Vector3 = Vector3(input.x, 0, input.y)
		
		velocity.x = move_toward(velocity.x, dash_direction.x * dash_speed, dash_acceleration)
		velocity.z = move_toward(velocity.z, dash_direction.z * dash_speed, dash_acceleration)
