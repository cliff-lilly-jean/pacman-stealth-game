class_name AIMoveComponent extends Component

@export var entity: Enemy
@export var speed: float = 4.0
@export var rotation_speed: float = 4.0

var direction: Vector3

func move(delta: float) -> void:
	if entity.nav_agent.is_navigation_finished():
		entity.linear_velocity.x = 0.0
		entity.linear_velocity.z = 0.0
		return
		
	
	var next_path_position : Vector3 = entity.nav_agent.get_next_path_position()
	direction = next_path_position - entity.global_position
	
	
	direction.y = 0.0
	
	if direction.length() < 0.1:
		entity.linear_velocity.x = 0.0
		entity.linear_velocity.z = 0.0
		return

	direction = direction.normalized()
	
	entity.linear_velocity.x = direction.x * speed
	entity.linear_velocity.z = direction.z * speed
	
	# Rotate the movement toward the direction
	rotate_to_direction(delta)

func rotate_to_direction(delta: float) -> void:
	# Ge the direction the entity is traveling
	var travel_direction: Vector3 = entity.linear_velocity
	travel_direction.y = 0.0
	
	if travel_direction.length() < 0.1:
		return
		
	travel_direction = travel_direction.normalized()
	
	var target_angle : float = atan2(travel_direction.x, travel_direction.z)
	
	entity.rotation.y = lerp_angle(entity.rotation.y, target_angle, rotation_speed * delta)
