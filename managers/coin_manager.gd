class_name CoinManager extends Node

@export var ground: Ground
@export var coin_count: int
@export var coins: Array[PackedScene]

@onready var spawn_area_length = ground.length
@onready var spawn_area_width = ground.width

func _ready() -> void:
	
	for item in range(coin_count):
		var coin: Coin = coins.pick_random().instantiate() as Coin
	
		spawn_random_coin(coin)	

func spawn_random_coin(new_coin) -> void:
	var random_x_point: float = randf_range(-spawn_area_length / 2.0, spawn_area_length / 2.0)
	var random_z_point: float = randf_range(-spawn_area_width / 2.0, spawn_area_width / 2.0)
	var coin_placement_point = Vector3(random_x_point, 1, random_z_point)
	
	new_coin.global_position = coin_placement_point
	
	## Add the coin to the world
	add_child(new_coin)
