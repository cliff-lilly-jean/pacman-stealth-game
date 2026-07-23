class_name CoinManager extends Node

@export var ground: Ground
@export var coin_count: int
@export var coins: Array[PackedScene]

var spawn_area_length: int
var spawn_area_width : int

var total_coins: Array = []
var new_coin

func _ready() -> void:
	spawn_area_length = ground.length
	spawn_area_width = ground.width
	
func spawn_random_coin() -> void:
	for item in range(coin_count):
		var coin: Coin = coins.pick_random().instantiate() as Coin
		new_coin = coin
		total_coins.append(coin)
		
	var random_x_point: float = randf_range(-spawn_area_length / 2.0, spawn_area_length / 2.0)
	var random_z_point: float = randf_range(-spawn_area_width / 2.0, spawn_area_width / 2.0)
	var coin_placement_point = Vector3(random_x_point, 1, random_z_point)
	
	new_coin.global_position = coin_placement_point
	
	## Add the coin to the world
	add_child(new_coin)
