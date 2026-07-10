class_name InputComponent extends Component

var input_direction: Vector2
var jump_input: bool
var dash_input: bool
var sprint_input: bool

func update() -> void:
	input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")
	jump_input = Input.is_action_just_pressed("jump")
	dash_input = Input.is_action_just_pressed("dash")
	sprint_input = Input.is_action_pressed("sprint")
