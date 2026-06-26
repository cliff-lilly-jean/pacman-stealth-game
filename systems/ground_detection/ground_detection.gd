class_name GroundDetection extends Node3D

@export var body: RigidBody3D

@export var right_ground_check_postion : float = -0.5
@export var left_ground_check_postion : float = 0.5
@export var front_ground_check_postion : float = 0.5
@export var rear_ground_check_postion : float = -0.5

@onready var right_check: RayCast3D = $RightCheck
@onready var left_check: RayCast3D = $LeftCheck
@onready var front_check: RayCast3D = $FrontCheck
@onready var rear_check: RayCast3D = $RearCheck

var casts: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	right_check.position.x = right_ground_check_postion
	left_check.position.x = left_ground_check_postion
	front_check.position.z = front_ground_check_postion
	rear_check.position.z = rear_ground_check_postion
	
	for child in get_children():
		if child is RayCast3D:
			casts.append(child)
	
func _physics_process(_delta: float) -> void:
	
	# Gravity
	body.linear_velocity.y += -1.0
	
func is_grounded() -> bool:
	for cast in casts:
		if cast is RayCast3D and cast.is_colliding():
				return true
	return false
