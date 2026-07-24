class_name CoinManager extends Node3D

@export var ground: Ground
@export var coin_count: int
@export var coins: Array[PackedScene]

var spawn_area_length: float
var spawn_area_width : float
var total_coins: Array[Coin] = []
var coin_placement_point: Vector3

func _ready() -> void:
	spawn_area_length = ground.length
	spawn_area_width = ground.width
	
	#spawn_random_coin()
	
func spawn_random_coin() -> void:
	
	while total_coins.size() < coin_count:
			
		get_new_spawn_point()
	
		if not is_spawn_position_clear(coin_placement_point):
			get_new_spawn_point()
			#continue
		
		var coin: Coin = coins.pick_random().instantiate() as Coin
		if coin == null:
			continue
			
		## Add the coin to the world
		add_child(coin)
		coin.global_position = coin_placement_point
		
		
		total_coins.append(coin)
		
		await get_tree().physics_frame
		
		for i in total_coins.size():
			total_coins[i].number = i + 1
			total_coins[i].label.text = str(i + 1)
	
		

func is_spawn_position_clear(spawn_position: Vector3) -> bool:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var check_shape: SphereShape3D = SphereShape3D.new()
	check_shape.radius = 1.0
	
	var query: PhysicsShapeQueryParameters3D = PhysicsShapeQueryParameters3D.new()
	query.shape = check_shape
	query.transform = Transform3D(Basis.IDENTITY, spawn_position)
	query.collide_with_bodies = true
	query.collide_with_areas = true
	
	## Check layers 1,2.
	## Ignore on layers 4.
	query.collision_mask = (1 << 0) | (1 << 1) | (1 << 2)
	
	var collisions: Array[Dictionary] = space_state.intersect_shape(query, 32)
	
	return collisions.is_empty()

func get_new_spawn_point() -> void:
	var random_x_point: float = randf_range(-spawn_area_length / 2.0, spawn_area_length / 2.0)
	var random_z_point: float = randf_range(-spawn_area_width / 2.0, spawn_area_width / 2.0)
	coin_placement_point = Vector3(random_x_point, 1, random_z_point)
