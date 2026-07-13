class_name Player extends Entity

@export var gravity: float
@export var camera_controller: CameraController
@export var input_manager: InputManager

@onready var stamina_component: StaminaComponent = $StaminaComponent

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	movement_input = input_manager.input_direction
	movement_reference = camera_controller
	
	input_manager.update()
	apply_gravity(delta)
	move_and_slide()

func apply_gravity(delta: float) -> void:
	velocity.y -= gravity

	
	
