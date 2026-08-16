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
@export var dash_deceleration: float

@export_group("Gravity")
@export var gravity: float

@export_group("Misc")
@export var facing_rotation_speed: float

@onready var stamina_component: StaminaComponent = $StaminaComponent

var input_direction: Vector2
var desired_velocity: Vector3

func _physics_process(delta: float) -> void:
	input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")
	
	rotate_facing_direction(delta)
		
	dash(input_direction, delta)
	apply_gravity(delta)
	
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	

func dash(input: Vector2, delta: float) -> void:
	if Input.is_action_just_pressed("dash"):
		
		var dash_direction: Vector3 = Vector3(input.x, 0, input.y)
		var dash_velocity: Vector3 = get_desired_velocity(dash_direction, dash_speed)
		
		velocity.x = move_toward(velocity.x, dash_velocity.x, dash_acceleration * delta)
		velocity.z = move_toward(velocity.z, dash_velocity.z, dash_acceleration * delta)

func get_desired_velocity(direction: Vector3, speed: float) -> Vector3:
	return transform.basis * direction * speed

func rotate_facing_direction(delta: float) -> void:
	if input_direction.length() > 0.1:
		var target_angle: float = atan2(velocity.x, velocity.z)
		mesh.global_rotation.y = lerp_angle(mesh.global_rotation.y, target_angle, facing_rotation_speed * delta)
