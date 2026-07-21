extends Node

var bronze_coin = preload("res://scenes/entities/collectables/coins/bronze_coin.tscn")
var gold_coin = preload("res://scenes/entities/collectables/coins/gold_coin.tscn")

@onready var player = %Player
@onready var coins: Node3D = %Coins
@onready var score: Score = %Score
@onready var ground: Ground = %Ground

var value: int

func _ready() -> void:
	## Set the default value for the score total
	score.total = 0
	
	## Set the length and width of the ground floor
	ground.length = 100
	ground.width = 100
	
	## Coins
	for coin in coins.get_children():
		
		var total_coins = coins.get_child_count()
		
		if coin is Coin:
			score.points += coin.coin_resource.value
			score.total = total_coins
			value = coin.coin_resource.value
			
			## Coin collected signal
			coin.collected.connect(on_collected)

func on_collected(collectable_value: int) -> void:
	score.update_score.emit(collectable_value)

	
