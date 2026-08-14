class_name DetectionArea extends Area3D

@export var shape_radius: float
@export var shape_height: float = 1
@export var fov_width: float

@onready var collider = $CollisionShape3D


func _ready():
	
	collider.shape.radius = shape_radius
	collider.shape.height = shape_height
	
		
