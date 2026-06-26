class_name InputController extends Node3D

var move_direction : Vector2 = Vector2.ZERO
var joystick_direction : Vector2
var mouse_direction : Vector2
var jump_pressed : bool = false
var dash_pressed : bool = false


func process_inputs() -> void:
	move_direction = Input.get_vector("move_left","move_right", "move_forward", "move_backward")
	jump_pressed = Input.is_action_just_pressed("jump")
	dash_pressed = Input.is_action_just_pressed("dash")
	joystick_direction = Input.get_vector("pan_left","pan_right","pan_up","pan_down")
	

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Capture Input even when Paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _unhandled_input(event: InputEvent) -> void:
	
	# Capture Mouse Movement
	if event is InputEventMouseMotion:
		mouse_direction = event.screen_relative
	
	# Pause State
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
	
	if get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
			return
			
	if get_tree().paused:
		return
