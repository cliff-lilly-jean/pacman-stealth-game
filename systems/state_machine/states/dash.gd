class_name Dash extends State

@export var dash_time: float = 0.15
@export var force : float = 40.0
@export var entity: RigidBody3D

var direction : Vector2
var dash_timer: float = 0.0

func enter() -> void:
	if entity == null:
		print_debug("The dash node needs a entity attached to it")
		return
	
	## Set dash timer to the dash time when the state is entered. 
	dash_timer = dash_time
	
	direction = entity.input_controller.move_direction.rotated(-entity.camera_controller.spring_arm.global_rotation.y)
	
	## Squish then spring back
	squish_and_stretch(0.2)
	
	
func physics_update(delta: float) -> void:
	
	## Use delta to decrease the dash timer to 0 at a fixed rate
	dash_timer -= delta
	
	if entity.input_controller.jump_pressed and entity.ground_detection.is_grounded() and dash_timer <= 0.0:
		change_state.emit(self, "jump")
		return
	
	if dash_timer <= 0.0:
		change_state.emit(self, "move")
		return


func squish_and_stretch(amount: float) -> void:
	entity.model.scale = Vector3(1,1,0.7)
	var t = create_tween()
	t.tween_property(entity.model, "scale",
	Vector3.ONE, amount).set_trans(Tween.TRANS_ELASTIC)
	
	entity.linear_velocity.x = direction.x * force
	entity.linear_velocity.z = direction.y * force
	

func hit_stop(duration) -> void:
	## Freeze for a few frames
	Engine.time_scale = 0.05
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0
