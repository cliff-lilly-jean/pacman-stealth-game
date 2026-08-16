class_name DetectionArea extends Area3D

@export var fov_width: float
@export var view_distance: float
@export var shape_height: float = 1

@onready var collider = $CollisionShape3D
@onready var vision_cone: MeshInstance3D = $VisionCone
@onready var ray_cast: RayCast3D = $RayCast3D

signal target_found(target_position: Vector3)

func _ready():
	collider.shape.radius = view_distance
	collider.shape.height = shape_height
	ray_cast.target_position.z = view_distance
	
	generate_vision_cone()


func generate_vision_cone() -> void:
	var cone_mesh = vision_cone.mesh as ImmediateMesh
	
	cone_mesh.clear_surfaces()
	
	var half_fov = deg_to_rad(fov_width / 2)
	var segments = 24
	
	cone_mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
	
	for i in range(segments):
		var angle_one = lerp(
			-half_fov,
			half_fov,
			float(i) / segments
		)
		
		var angle_two = lerp(
			-half_fov,
			half_fov,
			float(i + 1) / segments
		)
		
		cone_mesh.surface_add_vertex(Vector3.ZERO)
		
		cone_mesh.surface_add_vertex(
			Vector3(
				sin(angle_one) * view_distance,
				0,
				cos(angle_one) * view_distance
			)
		)
		
		cone_mesh.surface_add_vertex(
			Vector3(
				sin(angle_two) * view_distance,
				0,
				cos(angle_two) * view_distance
			)
		)
		
	cone_mesh.surface_end()


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var direction = global_position.direction_to(body.global_position)
		
		var facing = global_transform.basis.tdotz(direction)
		var fov = cos(deg_to_rad(fov_width / 2))
		
		if facing < fov:
			print("Player is outside FOV")
		else:
			ray_cast.target_position = ray_cast.to_local(body.global_position)
			ray_cast.force_raycast_update()
			
			if ray_cast.is_colliding():
				var hit = ray_cast.get_collider()
				
				print("LookDirection hit: ", hit)
				
				if hit is Player:
					target_found.emit(body.global_position)
					
