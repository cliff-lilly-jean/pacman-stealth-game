class_name Patrol extends State

@export var entity: Ghost

var start_point : Vector3
var end_point :  Vector3
var current_patrol_point :  Vector3
var going_to_end_patrol_point : bool

# What does it need to react to?
func _ready() -> void:

	#entity.vision_system.target_spotted.connect(on_target_spotted)
	pass

func enter() -> void:
	
	## Set the initial start position of the patrol
	start_point = entity.global_position
	
	## Set the initial end position of the patrol by choosing a random raange value
	end_point = start_point + Vector3(randf_range(-40, 40), 0.0, randf_range(-40, 40))
	
	## Begin the patrol route by going to the end postion
	set_patrol_point(end_point)
	
	## Reset the vision area size
	#entity.vision_system.update_vision_area_size(entity.vision_system.data.collider_length, entity.vision_system.data.collider_width)

	
func physics_update(delta: float) -> void:
		
	if entity.nav_agent.is_navigation_finished():
		switch_patrol_point()
		return

## Used to switch the patrol route between the starting route and an end route
func switch_patrol_point() -> void:
	if going_to_end_patrol_point:
		going_to_end_patrol_point = false
		set_patrol_point(start_point)
	else:
		going_to_end_patrol_point = true
		set_patrol_point(end_point)

## Used to set a new patrol point
func set_patrol_point(new_point: Vector3) -> void:
	
	current_patrol_point = new_point
	entity.nav_agent.set_target_position(current_patrol_point)
	

func on_target_spotted() -> void:
	pass
	#if entity.vision_system.can_see_target():
		#change_state.emit(self, "investigate")
		#return
