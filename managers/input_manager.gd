class_name InputManager extends Node

var input_direction: Vector2
var jump_input: bool
var dash_input: bool
var sprint_input: bool

signal changed_direction(direction: Vector2)
signal jump_pressed
signal dash_pressed
signal sprint_pressed

func _ready() -> void:
	Input.mouse_mode =Input.MOUSE_MODE_CAPTURED

func update() -> void:
	input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")
	jump_input = Input.is_action_just_pressed("jump")
	dash_input = Input.is_action_just_pressed("dash")
	sprint_input = Input.is_action_pressed("sprint")
	
	changed_direction.emit(input_direction)
	
	if jump_input:
		jump_pressed.emit()
		
	if dash_input:
		dash_pressed.emit()
		
	if sprint_input:	
		sprint_pressed.emit()
	
func _input(event) -> void:
	if Input.is_action_just_pressed("pause"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
