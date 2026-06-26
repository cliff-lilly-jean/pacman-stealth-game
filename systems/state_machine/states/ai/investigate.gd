class_name Investigate extends State

@export var entity: Ghost

func _ready() -> void:
	pass
	## Connect the signal
	#entity.vision_system.body_entered.connect(on_vision_area_entered)
	#entity.vision_system.body_exited.connect(on_vision_area_exited)

func enter() -> void:
	pass
	## Change the collision area color
	#entity.vision_system.change_to_collider_warning_color()
	#
	#entity.vision_system.update_vision_area_size(entity.vision_system.data.spotted_collider_length, entity.vision_system.data.spotted_collider_width)


func exit() -> void:
	pass
	#entity.vision_system.data.collider_color.albedo_color = entity.vision_system.data.base_collider_color
	#
	### Reset the vision area size
	#entity.vision_system.update_vision_area_size(entity.vision_system.data.collider_length, entity.vision_system.data.collider_width)

func physics_update(_delta: float) -> void:
	
	if entity.vision_system.target_in_vision_area:
		## TODO: Strart the investigation timer
		## TODO: Move to the last known position
		pass
	
	## TODO: If the target leaves the vision area, Decrease the size of the vision area, Travel to the last known position of the target, Reset the raycast target position, transition into a search state

func on_vision_area_entered(body: Node3D) -> void:
	
	if body == entity.target:
		pass

	
func on_vision_area_exited(body: Node3D) -> void:
	
	if body == entity.target:
		change_state.emit(self, "patrol")
		return
