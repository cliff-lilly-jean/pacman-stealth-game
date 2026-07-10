class_name InputComponent extends Component

var input_direction: Vector2
var jump_input: bool

func update(delta: float) -> void:
	input_direction = Input.get_vector("move_left","move_right","move_forward","move_backward")
	jump_input = Input.is_action_just_pressed("jump")
