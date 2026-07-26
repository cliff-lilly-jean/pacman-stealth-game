extends Node

@onready var player = %Player
@onready var ground: Ground = %Ground
@onready var coin_manager: CoinManager = %CoinManager
@onready var next_coin: NextCoinLabel = %NextCoinLabel
@onready var game_time: GameTime = %GameTimeLabel


func _ready() -> void:
	
	## Wait until the ground is spawned
	await get_tree().physics_frame
	
	##Coins
	await coin_manager.spawn_random_coin()
	
	next_coin.next_coin_number = coin_manager.total_coins[-1].number
	next_coin.text = str("Find Coin: ", next_coin.next_coin_number)

	EventBus.coin_collected.connect(on_coin_collected)
	

func on_coin_collected(number: int) -> void:
	## Check if number is equal to the Next Coin number
	if number != next_coin.next_coin_number:
		print("Incorrect number")
		var incorrect_number_in_array = coin_manager.total_coins.find(number)
		coin_manager.total_coins.remove_at(incorrect_number_in_array)
		print(coin_manager.total_coins)
		## Subtract x seconds from the Game Time if number is not equal to the Next Coin number
		game_time.game_time_in_seconds -= 30
		## Alert Enemies in x radius
		print("Alerting closest enemies")
		## Chase the Player
		print("Chasing the Player")
	else:
		## Change the Next Coin Label messsage
		## Update the Next coin number
		var correct_number_in_array = coin_manager.total_coins.find(number)
		coin_manager.total_coins.remove_at(correct_number_in_array)
		var new_next_number = coin_manager.total_coins.max()
		EventBus.next_coin_collected.emit(new_next_number)

	
