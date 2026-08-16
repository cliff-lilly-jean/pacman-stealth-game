class_name Ghost extends CharacterBody3D

@export var speed: float
@export var patrol_distance_length: float
@export var look_rotation_speed: float
@onready var body: MeshInstance3D = $Body

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var detection_area: DetectionArea = $DetectionArea


## Patrol Variables
var start_patrol_locaton: Vector3
var end_patrol_location: Vector3
var next_position: Vector3
var moving_to_end:bool = true


## CHASE
## Set the target position, the Player
## Get the next path position
## Move toward he next position

func _ready() -> void:
	
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
	velocity = direction * speed
	
	if navigation_agent.is_navigation_finished():
		## Determine if the ghost has finished the patrol to the edn point, if so change the route to the starting point  and travel to that
		if moving_to_end:
			navigation_agent.target_position = start_patrol_locaton
			next_position = navigation_agent.get_next_path_position()
			moving_to_end = false
		else:
			navigation_agent.target_position = end_patrol_location
			moving_to_end = true

## Investigate
func investigate() -> void:
	pass
	## The player enters the detection area, inside the fov
	## If the player is visible and not obstructed by an obstacle, change the navigation target position to the player's last known position and travel to it
	## If the player is visible and obstructed, continue on with the regular navigation route
			
func look_rotation(delta: float) -> void:
	rotation.y = lerp_angle(
		rotation.y,
		atan2(
			next_position.x - global_position.x,
			next_position.z - global_position.z
		),
		look_rotation_speed * delta
	)
