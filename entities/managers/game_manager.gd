extends Node

@onready var player = %Player
@onready var score: Score = %Score
@onready var ground: Ground = %Ground
@onready var coin_manager: CoinManager = %CoinManager

var value: int

func _ready() -> void:
	## Set the default value for the score total
	score.total = coin_manager.coin_count
	
	## Set the length and width of the ground floor
	ground.length = 100
	ground.width = 100
	
	EventBus.coin_collected.connect(on_coin_collected)
	

func on_coin_collected(collectable_value: int) -> void:
	EventBus.score_updated.emit(collectable_value)

	
