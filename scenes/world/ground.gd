class_name Ground extends StaticBody3D

@export var length: float
@export var width: float

@onready var collision: CollisionShape3D = $CollisionShape3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var box_shape: Shape3D = BoxShape3D.new()
var box_mesh: Mesh = BoxMesh.new()

func _ready() -> void:
	box_mesh.size.x = length
	box_mesh.size.z = width
	mesh.mesh = box_mesh
	
	box_shape.size.x = length
	box_shape.size.z = width
	collision.shape = box_shape
	
	
