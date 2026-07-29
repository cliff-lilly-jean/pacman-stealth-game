extends Node

@onready var player = %Player
@onready var ground: Ground = %Ground
@onready var coin_manager: CoinManager = %CoinManager
@onready var next_coin: NextCoinLabel = %NextCoinLabel
@onready var game_time: GameTime = %GameTimeLabel


func _ready() -> void:
	
	## Wait until the ground is spawned
	await get_tree().physics_frame
	
	next_coin.next_coin_number = (
		coin_manager.get_highest_coin_number()
	)
	next_coin.text = str("Find Coin: ", next_coin.next_coin_number)

	EventBus.coin_collected.connect(on_coin_collected)
	

func on_coin_collected(number: int) -> void:
	var is_correct_coin: bool = (
		number == next_coin.next_coin_number
	)
	
	## Remove the collected coin from the array.
	coin_manager.remove_coin_by_number(number)
	
	print("Collected coin: ", number)
	print("Coins remaining: ", coin_manager.total_coins.size())
	
	if not is_correct_coin:
		print("Incorrect number")
		
		game_time.game_time_in_seconds -= 30
		
		print("Alerting closest enemies")
		print("Chasing the Player")
	
	## No coins remain.
	if coin_manager.total_coins.is_empty():
		next_coin.next_coin_number = 0
		next_coin.text = "All coins collected!"
		return
	
	## Find the highest number still left in the array.
	var new_next_number: int = (
		coin_manager.get_highest_coin_number()
	)
	
	EventBus.next_coin_collected.emit(new_next_number)
		

	
