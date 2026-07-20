extends Node

@onready var player = %Player
@onready var coins: Node3D = %Coins
@onready var score: Score = %Score

var value: int

func _ready() -> void:
	score.total = 0
	
	## Coins
	for coin in coins.get_children():
		
		var total_coins = coins.get_child_count()
		
		if coin is Coin:
			score.points += coin.coin_resource.value
			score.total = total_coins
			value = coin.coin_resource.value
			
			## Coin collected signal
			coin.collected.connect(on_collected)

func on_collected(value: int) -> void:
	score.update_score.emit(value)

	
