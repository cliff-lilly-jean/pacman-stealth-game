extends State
class_name PatrolAI

@export var enemy: Enemy

var moving_to_end:bool = true


func physics_update(delta: float) -> void:
	enemy.next_position = enemy.nav_agent.get_next_path_position()
	
	var direction: Vector3 = enemy.global_position.direction_to(enemy.next_position)
	enemy.velocity = direction * enemy.stats.speed
	
	if enemy.nav_agent.is_navigation_finished():
		## Determine if the ghost has finished the patrol to the edn point, if so change the route to the starting point  and travel to that
		if moving_to_end:
			enemy.nav_agent.target_position = enemy.start_patrol_locaton
			moving_to_end = false
		else:
			enemy.nav_agent.target_position = enemy.end_patrol_location
			moving_to_end = true
