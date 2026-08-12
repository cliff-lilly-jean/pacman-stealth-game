class_name Ghost extends CharacterBody3D

@export var speed: float
@export var patrol_distance_length: float
@export var look_rotation_speed: float
@export var view_distance: float

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var look_direction: RayCast3D = $LookDirection
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var detection_area: DetectionArea = $DetectionArea

var start_patrol_locaton: Vector3
var end_patrol_location: Vector3
var next_position: Vector3
var moving_to_end:bool = true

## Investigate
## If Player is in Detection Area forward angle
## Change the Look Direction's Target Position
## Set the Target Position to the Look Directions's Target Position
## Get the Next Path Position
## Move toward The Next Path Position
## Reset Look Directions Target Position to Forward
## Scan the area. Rotate

## CHASE
## Set the target position, the Player
## Get the next path position
## Move toward he next position

func _ready() -> void:
	
	look_direction.target_position.z = view_distance
	detection_area.collider.shape.radius = view_distance
	
	set_navigation_route()
	
func _physics_process(delta: float) -> void:
	patrol()
	
	
	look_rotation(delta)
	move_and_slide()

func set_navigation_route() -> void:
	start_patrol_locaton = global_position
	end_patrol_location = Vector3(randf_range(start_patrol_locaton.x - patrol_distance_length, start_patrol_locaton.x + patrol_distance_length), global_position.y, randf_range(start_patrol_locaton.z - patrol_distance_length, start_patrol_locaton.z + patrol_distance_length))
	
	navigation_agent.target_position = end_patrol_location

## Patrol
func patrol() -> void: 
	next_position = navigation_agent.get_next_path_position()
	
	var direction: Vector3 = global_position.direction_to(next_position)
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if navigation_agent.is_navigation_finished():
		if moving_to_end:
			navigation_agent.target_position = start_patrol_locaton
			next_position = navigation_agent.get_next_path_position()
			moving_to_end = false
		else:
			navigation_agent.target_position = end_patrol_location
			moving_to_end = true
			
func look_rotation(delta: float) -> void:
	rotation.y = lerp_angle(
		rotation.y,
		atan2(
			next_position.x - global_position.x,
			next_position.z - global_position.z
		),
		look_rotation_speed * delta
	)
