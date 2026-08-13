class_name DetectionArea extends Area3D

@export var shape_radius: float
@export var shape_height: float = 1
@export var fov_width: float

@onready var collider = $CollisionShape3D


func _ready():
	
	collider.shape.radius = shape_radius
	collider.shape.height = shape_height
	body_entered.connect(_on_body_entered)
	
	var mesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
	mesh.surface_add_vertex(Vector3.LEFT)
	mesh.surface_add_vertex(Vector3.FORWARD)
	mesh.surface_add_vertex(Vector3.ZERO)
	mesh.surface_end()
	
	
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		## Where the player is coming from
		var direction = global_position.direction_to(body.global_position)
		
		## Whether the player is coming form the front or back
		var facing = global_transform.basis.tdotz(direction)
		var fov = cos(rad_to_deg(fov_width / 2)) ## divide by 2 to represent the two sides of the viewing angle on the z axes, left and right
		
		if facing < fov:
			print("coming from behind, I cant see you")
		else: 
			print("Coming from the front, I see you!")
		
