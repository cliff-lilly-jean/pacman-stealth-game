class_name Ghost extends Enemy

@export var ai_move_component: AIMoveComponent
@export var nav_agent: NavigationAgent3D
@export var fov: FOV

	
func _physics_process(delta):
	ai_move_component.move(delta)
	
