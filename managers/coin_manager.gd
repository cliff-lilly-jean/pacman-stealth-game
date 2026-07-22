class_name CoinManager extends Node

@export var ground: Ground
@export var coin_count: int

var bronze_coin = preload("res://scenes/entities/collectables/coins/bronze_coin.tscn")
var gold_coin = preload("res://scenes/entities/collectables/coins/gold_coin.tscn")

var coins: Array[PackedScene]

func _ready() -> void:
	coins.append(bronze_coin)
	coins.append(gold_coin)
	
	var length = ground.length
	var width = ground.width
	
	var ground_dimensions: Vector3 = Vector3(length, 0, width)
	
	for coin in coin_count:
		var random_x_point: float = randf_range(-length / 2.0, length / 2.0)
		var random_z_point: float = randf_range(-width / 2.0, width / 2.0)
		var coin_placement_point = Vector3(random_x_point, 1, random_z_point)
		get_random_coin(coin_placement_point)


func get_random_coin(placement_point: Vector3) -> void:
	var random_coin_number: int = randi_range(0, len(coins) -1)
	var selected_coin: PackedScene = coins[random_coin_number]
	var coin_instance: Node3D = selected_coin.instantiate()

	add_child(coin_instance)
	coin_instance.global_position = placement_point
		
