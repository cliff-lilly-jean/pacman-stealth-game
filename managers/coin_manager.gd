class_name CoinManager extends Node3D

@export var ground: Ground
@export var coin_count: int
@export var coins: Array[PackedScene]

@onready var coin_spawn_detector: Area3D

var spawn_area_length: int
var spawn_area_width : int
var total_coins: Array = []
var new_coin
var coin_placement_point: Vector3

func _ready() -> void:
	spawn_area_length = ground.length
	spawn_area_width = ground.width
	
func spawn_random_coin() -> void:
	for item in range(coin_count):
		var coin: Coin = coins.pick_random().instantiate() as Coin
		new_coin = coin
		total_coins.append(coin)
		
		get_new_spawn_point()
	
		if not is_spawn_position_clear(coin_placement_point):
			get_new_spawn_point()
	
	new_coin.global_position = coin_placement_point
	
	## Add the coin to the world
	add_child(new_coin)

func is_spawn_position_clear(spawn_position: Vector3) -> bool:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var check_shape: SphereShape3D = SphereShape3D.new()
	check_shape.radius = 0.5
	
	var query: PhysicsShapeQueryParameters3D = PhysicsShapeQueryParameters3D.new()
	query.shape = check_shape
	query.transform = Transform3D(Basis.IDENTITY, spawn_position)
	query.collide_with_bodies = true
	query.collide_with_areas = true
	
	var collisions: Array[Dictionary] = space_state.intersect_shape(query, 1)
	
	print(collisions.is_empty())
	return collisions.is_empty()

func get_new_spawn_point() -> void:
	var random_x_point: float = randf_range(-spawn_area_length / 2.0, spawn_area_length / 2.0)
	var random_z_point: float = randf_range(-spawn_area_width / 2.0, spawn_area_width / 2.0)
	coin_placement_point = Vector3(random_x_point, 1, random_z_point)
