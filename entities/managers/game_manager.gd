extends Node

@onready var player = %Player
@onready var score: Score = %Score
@onready var ground: Ground = %Ground
@onready var coin_manager: CoinManager = %CoinManager

var value: int

func _ready() -> void:
	
	## Wait until the ground is spawned
	await get_tree().physics_frame
	
	##Coins
	await coin_manager.spawn_random_coin()
	
	score.total = coin_manager.total_coins.size()
	for coin in coin_manager.total_coins:
		score.total_points += coin.coin_resource.value
		

	EventBus.coin_collected.connect(on_coin_collected)
	

func on_coin_collected(collectable_value: int) -> void:
	score.total -= 1 
	EventBus.score_updated.emit(collectable_value)

	
