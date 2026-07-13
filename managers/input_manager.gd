class_name InputManager extends Node

var input_direction: Vector2
var jump_input: bool
var dash_input: bool
var sprint_input: bool

signal changed_direction(direction: Vector2)
signal jump_pressed
signal dash_pressed
signal sprint_pressed

func update() -> void:
	update_direction()
	jump()
	dash()
	sprint()

func update_direction() -> void:
	input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")
	print("Move")
	changed_direction.emit(input_direction)
	
func jump() -> void:
	if Input.is_action_just_pressed("jump"):
		print("Jump")
		jump_pressed.emit()

func dash() -> void:
	if Input.is_action_just_pressed("dash"):
		print("Dash")
		dash_pressed.emit()

func sprint() -> void:
	if Input.is_action_pressed("sprint"):
		print("Sprint")
		sprint_pressed.emit()
		
