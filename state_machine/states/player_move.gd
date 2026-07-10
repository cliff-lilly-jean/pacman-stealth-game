extends State

@export var move_speed: float
@export var sprint_speed: float
@export var dash_speed: float
@export var acceleration: float

func apply_move(input: Vector2, delta: float) -> void:
	
	var speed : float = sprint_speed if Input.is_action_pressed("sprint") else move_speed
	var desired_velocity: Vector3 = Vector3(input.x, 0, input.y) * speed
	
	#if Input.is_action_pressed("sprint"):
		#stamina.use(2.5)
	
	if input.length() >= 0.1:
		entity.velocity.x = move_toward(entity.velocity.x, desired_velocity.x,  acceleration * delta)
		entity.velocity.z = move_toward(entity.velocity.z, desired_velocity.z, acceleration * delta)
	else:
		entity.velocity.x = move_toward(entity.velocity.x, 0, acceleration * delta)
		entity.velocity.z = move_toward(entity.velocity.z, 0, acceleration * delta)

func update(delta: float) -> void:
	if entity.is_on_floor() and Input.is_action_just_pressed("jump"):
		change_state.emit(self, 'jump')

func physics_update(delta: float) -> void:
	apply_move(entity.input_component.input_direction, delta)
