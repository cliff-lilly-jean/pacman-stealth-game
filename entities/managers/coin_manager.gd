class_name CoinManager extends Node3D

@export var ground: Ground
@export var coin_count: int ## Amount of coins to be spawned in a level
@export var coins: Array[PackedScene]
@export var navigation_area: NavigationRegion3D

var total_coins: Array[Coin] = []
var coin_placement_point: Vector3
var _is_spawning: bool = false

func _ready() -> void:
	await _wait_for_navigation_ready()
	
	spawn_random_coin()

## Spawns a coin in a random position, if the position is blocked it chooses another one
func spawn_random_coin() -> void:
	if _is_spawning:
		push_warning("CoinManager: spawn_random_coin() called while already spawning — ignoring duplicate call.")
		return
	_is_spawning = true
	
	while total_coins.size() < coin_count:
		var spawn_point: Vector3 = await get_clear_spawn_point()

		var scene: PackedScene = coins.pick_random()
		if scene == null:
			continue

		var coin: Coin = scene.instantiate() as Coin
		if coin == null:
			continue

		add_child(coin)
		coin.global_position = spawn_point
		total_coins.append(coin)

		await get_tree().physics_frame

		for i in total_coins.size():
			total_coins[i].number = i + 1
			total_coins[i].label.text = str(i + 1)
	
	print(total_coins[0].global_position)
	_is_spawning = false
	
	EventBus.coins_spawned.emit()

## CHecks if a spawn area isnt hindered by any obstacles preventing the coin from loading in
func is_spawn_position_clear(spawn_position: Vector3) -> bool:
	var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	
	var check_shape: SphereShape3D = SphereShape3D.new()
	check_shape.radius =  10.0
	
	var query: PhysicsShapeQueryParameters3D = PhysicsShapeQueryParameters3D.new()
	query.shape = check_shape
	query.transform = Transform3D(Basis.IDENTITY, spawn_position)
	query.collide_with_bodies = true
	query.collide_with_areas = true
	
	## Check layers 1,2,3.
	## Ignore on layers 4.
	query.collision_mask = (1 << 0) | (1 << 1) | (1 << 2) 
	
	var collisions: Array[Dictionary] = space_state.intersect_shape(query, 1)
	
	return collisions.is_empty()

## Uses the navigation region to cdecide the available areas that a coin can spawn
func get_new_spawn_point() -> Vector3:
	var map_rid: RID = navigation_area.get_navigation_map()
	
	coin_placement_point = NavigationServer3D.map_get_random_point(map_rid, 1, true)
	
	return coin_placement_point

## Removes the coin by its number instead of by its index in teh array
func remove_coin_by_number(number: int) -> void:
	for coin in total_coins:
		if coin.number == number:
			total_coins.erase(coin)
			return

## Determines which is the next highest number to search for
func get_highest_coin_number() -> int:
	var highest_number: int = 0
	
	for coin in total_coins:
		if coin.number > highest_number:
			highest_number = coin.number
	
	return highest_number

## Gets a suitable point for the coin to spwan
func get_clear_spawn_point() -> Vector3:
	var MAX_ATTEMPTS: int = 300 * coin_count
	var point: Vector3 = Vector3.ZERO
	
	for attempt in MAX_ATTEMPTS:
		point = get_new_spawn_point()
		
		## If the point is the initial Vector3.zero location, that means that the ground isnt fully loaded in and wait a frame
		if point.is_zero_approx():
			await get_tree().physics_frame
			continue

		if is_spawn_position_clear(point):
			return point
		await get_tree().physics_frame
	
	push_warning("CoinManager: couldn't find a clear spot after %d tries!" % MAX_ATTEMPTS)
	return point
		
## Waits for the navigation region to be ready 
func _wait_for_navigation_ready() -> void:
	var map_rid: RID = navigation_area.get_navigation_map()
	
	# The map's "iteration id" stays at 0 until it's synced once.
	while NavigationServer3D.map_get_iteration_id(map_rid) == 0:
		await get_tree().physics_frame
		
	# ...AND wait for the map to actually contain registered regions.
	while NavigationServer3D.map_get_regions(map_rid).is_empty():
		await get_tree().physics_frame
	
	# One more frame of breathing room, for good measure.
	await get_tree().physics_frame
