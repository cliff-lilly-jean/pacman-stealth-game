extends Node

@onready var player = %Player
@onready var coins: Node3D = %Coins
@onready var score: Score = %Score

var value: int

func _ready() -> void:
	
	## Coins
	for coin in coins.get_children():
		score.total = coins.get_child_count()
		
		if coin is Coin:
			value = coin.coin_resource.value
			
			## Coin collected signal
			coin.collected.connect(on_collected)

func on_collected() -> void:
	score.update_score.emit(value)

	
