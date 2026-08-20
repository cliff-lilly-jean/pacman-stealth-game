extends State
class_name	InvestigateAI

@export var enemy: Enemy
@export var investigation_view_distance_multipler: float
@export var timer: float

## If the PLAYER enters the DETECTION AREA and is inside the FOV, start a small INVESTIGATION TIMER and increase the size of the FOV by a percentage. If the INVESTIGATION TIMER reaches 0, increase the size of the FOV/DETECTION AREA and transition into a CHASE STATE. If the PLAYER exits the FOV, transition into the PATROL STATE

func enter() -> void:
	
	if enemy is Ghost:
		print("Before: ", enemy.detection_area.view_distance)
		var view_distance_increase_percentage: float = (investigation_view_distance_multipler / 100) * enemy.detection_area.view_distance
		enemy.detection_area.view_distance += view_distance_increase_percentage
		print("After: ", enemy.detection_area.view_distance)
		
		## Update the size of the vision cone and the raycast length and the collisnon shape radius
		enemy.detection_area.generate_vision_cone()
		enemy.detection_area.ray_cast.target_position.z = enemy.detection_area.view_distance
		enemy.detection_area.collider.shape.radius = enemy.detection_area.view_distance
	

func physics_update(delta: float) -> void:
	timer -= 1 * delta
	
	if timer <= 0.09:
		timer = 0
		return
		#print("Initialize the chase state")
