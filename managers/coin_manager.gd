class_name CoinManager extends Node

@export var ground: Ground
@export var coin_count: int
@export var coin_list: Array[Coin]

var bronze_coin = preload("res://scenes/entities/collectables/coins/bronze_coin.tscn")
var gold_coin = preload("res://scenes/entities/collectables/coins/gold_coin.tscn")

var coins: Array[PackedScene]
var new_coin: Node3D
var total_coins: Array[Node3D]

func _ready() -> void:
	coins.append(bronze_coin)
	coins.append(gold_coin)
	print(bronze_coin)
	
	var length = ground.length
	var width = ground.width
	
	for coin in coin_count:
		var random_x_point: float = randf_range(-length / 2.0, length / 2.0)
		var random_z_point: float = randf_range(-width / 2.0, width / 2.0)
		var coin_placement_point = Vector3(random_x_point, 1, random_z_point)
		new_coin = get_random_coin(coin_placement_point)
		total_coins.append(new_coin)


func get_random_coin(placement_point: Vector3) -> Node3D:
	var random_coin_number: int = randi_range(0, len(coins) -1)
	var selected_coin: PackedScene = coins[random_coin_number]
	
	var coin_instance: Node3D = selected_coin.instantiate()

	add_child(coin_instance)
	coin_instance.global_position = placement_point
	return coin_instance
		
