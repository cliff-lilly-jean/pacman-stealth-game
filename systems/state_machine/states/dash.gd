class_name Dash extends State

@export var dash_time: float = 0.15
@export var force : float = 40.0
@export var body: RigidBody3D

var direction : Vector2
var dash_timer: float = 0.0

func enter() -> void:
	if body == null:
		print_debug("The dash node needs a body attached to it")
		return
	
	## Set dash timer to the dash time when the state is entered. 
	dash_timer = dash_time
	
	direction = body.input_system.move_direction.rotated(-body.camera_system.spring_arm.global_rotation.y)
	
	body.linear_velocity.x = direction.x * force
	body.linear_velocity.z = direction.y * force
	
func physics_update(delta: float) -> void:
	
	## Use delta to decrease the dash timer to 0 at a fixed rate
	dash_timer -= delta
	
	if body.input_system.jump_pressed and body.ground_detection_system.is_grounded() and dash_timer <= 0.0:
		change_state.emit(self, "jump")
		return
	
	if dash_timer <= 0.0:
		change_state.emit(self, "move")
		return
