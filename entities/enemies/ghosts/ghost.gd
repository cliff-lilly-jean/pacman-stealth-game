class_name Ghost extends Enemy

@export var speed: float
@export var patrol_distance_length: float
@export var patrol_distance_modifier: float # Used to make sure the patrol routes arent too short
@export var look_rotation_speed: float


@onready var body: MeshInstance3D = $Body
@onready var detection_area: DetectionArea = $DetectionArea

## Patrol Variables
var start_patrol_locaton: Vector3
var end_patrol_location: Vector3
var next_position: Vector3


func _ready() -> void:
	set_navigation_route()
	
func _physics_process(delta: float) -> void:
	
	look_rotation(delta)
	move_and_slide()

func set_navigation_route() -> void:
	start_patrol_locaton = global_position
	end_patrol_location = Vector3(randf_range(start_patrol_locaton.x - patrol_distance_length, start_patrol_locaton.x + patrol_distance_length), global_position.y, randf_range((start_patrol_locaton.z - patrol_distance_modifier) - patrol_distance_length, (start_patrol_locaton.z + patrol_distance_modifier) + patrol_distance_length))
	
	nav_agent.target_position = end_patrol_location

			
func look_rotation(delta: float) -> void:
	rotation.y = lerp_angle(
		rotation.y,
		atan2(
			next_position.x - global_position.x,
			next_position.z - global_position.z
		),
		look_rotation_speed * delta
	)
