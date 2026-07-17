class_name Player extends Entity

@export_group("Move")
@export var move_speed: float
@export var acceleration: float
@export var deceleration: float

@export_group("Sprint")
@export var sprint_speed: float
@export var sprint_acceleration: float
@export var sprint_deceleration: float

@export_group("Dash")
@export var dash_speed: float
@export var dash_acceleration: float

@export_group("Jump")
@export var jump_force: float
@export var jump_gravity: float
@export var fall_gravity: float

var input_direction: Vector2
var desired_velocity: Vector3

@onready var stamina_component: StaminaComponent = $StaminaComponent

@onready var jump_sfx: AudioStreamPlayer = $SFX/JumpSFX

func _physics_process(delta: float) -> void:
	input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")
	
	move(input_direction, delta)
	sprint(input_direction, delta)
	dash(input_direction, delta)
	jump()
	apply_gravity(delta)
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		var gravity: float = jump_gravity if velocity.y > 0.0 else fall_gravity
		velocity.y -= gravity * delta
	elif velocity.y < 0.0:
		velocity.y = 0.0
	
func move(input: Vector2, delta: float) -> void:
	var direction: Vector3 = Vector3(input.x, 0, input.y).normalized()
	var move_velocity: Vector3  = get_desired_velocity(direction, move_speed)
	
	if input.length() > 0.1:
		var target_angle: float = atan2(move_velocity.x, move_velocity.z)
		mesh.global_rotation.y = lerp_angle(mesh.global_rotation.y, target_angle, 10 * delta)
	
	if input.length() >= 0.1:
		velocity.x = move_toward(velocity.x, move_velocity.x,  acceleration * delta)
		velocity.z = move_toward(velocity.z, move_velocity.z, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0, deceleration * delta)

func jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		jump_sfx.play()
	
	if Input.is_action_just_released("jump") and velocity.y > 0.0:
		velocity.y *= -0.25

func sprint(input: Vector2, delta: float) -> void:
	if Input.is_action_pressed("sprint"):
		
		var sprint_direction: Vector3 = Vector3(input.x, 0, input.y).normalized()
		var sprint_velocity: Vector3 = get_desired_velocity(sprint_direction, sprint_speed)
		
		velocity.x = move_toward(velocity.x, sprint_velocity.x,  sprint_acceleration * delta)
		velocity.z = move_toward(velocity.z, sprint_velocity.z , sprint_acceleration * delta)
		
	if Input.is_action_just_released("sprint"):
		velocity.x = move_toward(velocity.x, 0, sprint_deceleration * delta)
		velocity.z = move_toward(velocity.z, 0, sprint_deceleration * delta)

func dash(input: Vector2, delta: float) -> void:
	if Input.is_action_just_pressed("dash"):
		
		var dash_direction: Vector3 = Vector3(input.x, 0, input.y)
		var dash_velocity: Vector3 = get_desired_velocity(dash_direction, dash_speed)
		
		velocity.x = move_toward(velocity.x, dash_velocity.x, dash_acceleration * delta)
		velocity.z = move_toward(velocity.z, dash_velocity.z, dash_acceleration * delta)

func get_desired_velocity(direction: Vector3, speed: float) -> Vector3:
	return transform.basis * direction * speed
