class_name Player extends CharacterBody3D

@export_group("Gravity")
@export var gravity: float

@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var camera_controller: CameraController = $CameraController
@onready var input_manager: InputManager = $InputManager
@onready var stamina_component: StaminaComponent = $StaminaComponent

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	input_manager.update()

	apply_gravity(delta)
	move_and_slide()

func apply_gravity(delta: float) -> void:
	velocity.y -= gravity

	
	
