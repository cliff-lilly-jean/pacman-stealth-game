class_name DetectionArea extends Area3D

@export var shape_radius: float = 5
@export var shape_height: float = 1

@onready var collider = $CollisionShape3D

var shape: Shape3D = CapsuleShape3D.new()

func _ready():
	shape.radius = shape_radius
	shape.height = shape_height
	
	
