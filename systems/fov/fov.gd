class_name FOV extends Area3D

@export var entity: Ghost
@export var view_distance: float = 10

@onready var shape: CollisionShape3D = $Shape
@onready var ray: RayCast3D = $Ray

var in_area: bool = false

func _ready() -> void:
	
	## Create a default cylindar shape for the collision area
	shape.shape = CylinderShape3D.new()
	
	## Change the shapes' radius
	shape.shape.radius = view_distance
	
	## Connect the Body enterd signal and exited signals
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)
	
	## The length target position of the ray initial direction
	ray.target_position = Vector3.ZERO
	ray.target_position.z = view_distance


func _physics_process(_delta: float) -> void:
	
	track_target()

func on_body_entered(body: Node3D):
	
	if body == entity.target:
		in_area = true	

func on_body_exited(body: Node3D) -> void:
	if body == entity.target:
		in_area = false	

func track_target() -> void:
	
	## The direction to the target body
	var direction = global_position.direction_to(entity.target.global_position)
	
	## The direction of the target in relation to the front of the entity using the dot product
	var facing = global_transform.basis.z.dot(direction)
	
	## How wide to make the fov
	var fov = cos(deg_to_rad(80))
	
	if in_area  and facing > fov:
		ray.target_position = ray.to_local(entity.target.global_position)
		ray.force_raycast_update()
		
		if ray.is_colliding() and ray.get_collider() == entity.target:
			print(entity.target.name, " In view and about to follow")

### VISION CONE ##
#func create_collider_shape(length: float, width: float) -> void:
	#
	#var center_point = Vector2.ZERO ## The body's defauilt position
	#var left_point = Vector2(-width, length)
	#var right_point = Vector2(width, length)
	#
	### Create a new packed vector 2 array to hold the points
	#var shape_points : PackedVector2Array = PackedVector2Array()
#
	### Add the points to the packed array to create the shape
	#shape_points.append(center_point)
	#shape_points.append(left_point)
	#shape_points.append(right_point)
	#
	### Add the created points to the polygon shape
	#collider.polygon = shape_points
#
#func create_collider(length: float, width: float) -> void:
	#
	#var vertices : PackedVector3Array = PackedVector3Array() ## Used to create the angles of the shape
	#var indicies :  PackedInt32Array = PackedInt32Array() ## Used to create the angles of the shape
	#
	### Use the vertices to map out the points of the cone
	#vertices.append(Vector3.ZERO)
	#vertices.append(Vector3(-width, 0.03, length))
	#vertices.append(Vector3(width, 0.03, length))
	#
	#indicies.append(0)
	#indicies.append(1)
	#indicies.append(2)
	#
	#var arrays : Array = []
	#arrays.resize(Mesh.ARRAY_MAX)
	#
	#arrays[Mesh.ARRAY_INDEX] = indicies
	#arrays[Mesh.ARRAY_VERTEX] = vertices
	#
	#var cone_mesh : ArrayMesh = ArrayMesh.new()
	#cone_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	#
	#shape.mesh = cone_mesh
	#shape.material_override = data.collider_color
	#
	### Set the default values for the cone color and transparency
	#data.collider_color.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA ## Disable the transparency
	#data.collider_color.cull_mode = BaseMaterial3D.CULL_DISABLED ## Disable the cull mode
	#data.collider_color.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED ## Unshade the material so that shadows aren't shown in dark areas
	#data.collider_color.albedo_color = data.base_collider_color ## Change the visible color
