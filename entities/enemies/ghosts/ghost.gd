class_name Ghost extends CharacterBody3D

@export var patrol_distance_length: float

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var deection_area: DetectionArea = $DeectionArea
@onready var look_direction: RayCast3D = $LookDirection
@onready var mesh: MeshInstance3D = $MeshInstance3D

var start_patrol_locaton: Vector3
var end_patrol_location: Vector3

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
	set_navigation_target_position()
	

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func set_navigation_target_position() -> void:
	start_patrol_locaton = Vector3(global_position.x, 0, global_position.z)
	end_patrol_location = Vector3(randf_range(start_patrol_locaton.x, patrol_distance_length), 0, randf_range(start_patrol_locaton.z, patrol_distance_length))
	
	navigation_agent.target_position = start_patrol_locaton
	print("Nav start location: ", navigation_agent.target_position) 

## Patrol
func patrol() -> void: 
	pass
	## Set the target position
	## if at the start location move towrad the end position else move toward the start position
	if navigation_agent.is_target_reached():
		navigation_agent.get_next_path_position()
	## Get the Next Path Posiion, random point on map
	## Move to ward the next path position
	## If at the next path posiion
	## Repeat
