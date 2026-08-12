class_name DetectionArea extends Area3D

@export var shape_radius: float
@export var shape_height: float = 1

@onready var collider = $CollisionShape3D

#var shape: Shape3D = CylinderShape3D.new()

func _ready():
	
	collider.shape.radius = shape_radius
	collider.shape.height = shape_height
	
	
