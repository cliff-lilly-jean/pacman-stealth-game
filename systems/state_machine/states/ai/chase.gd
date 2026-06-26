class_name Chase extends State

@export var entity: Ghost
@export var chase_move_speed: float = 3

#@onready var default_vision_area_size: float = entity.vision_system.data.collider_width

var player_in_detection_area: bool = false


func _ready() -> void:
	pass
	## Connect the signal
	#entity.vision_system.body_entered.connect(on_vision_area_entered)
	#entity.vision_system.body_exited.connect(on_vision_area_exited)


func enter() -> void:
	
	## Increase the movement speed
	entity.ai_move_component.speed *= chase_move_speed
	

func physics_update(_delta: float) -> void:
	
	if player_in_detection_area:
		## Start the detection timer
		chase_target(entity.target)	

func on_vision_area_entered(body: Node3D) -> void:
	
	if body == entity.target:
		
		## If the target is in the vison area and the raycast is colliding with it, Increase the vision area size, Update the targets last known position, Use the raycast to navigate to the last known position of the target
		player_in_detection_area = true

	
func on_vision_area_exited(body: Node3D) -> void:
	
	if body == entity.target:
		player_in_detection_area = false
	
		change_state.emit(self, "patrol")
		return


func chase_target(target: Node3D) -> void:

	## Get the popsition of the target
	entity.last_known_position = target.global_position
	
	## Navigate toward the position of the target
	entity.nav_agent.set_target_position(entity.last_known_position)
