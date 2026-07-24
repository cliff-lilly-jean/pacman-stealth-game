extends Node

@onready var player = %Player
@onready var ground: Ground = %Ground
@onready var coin_manager: CoinManager = %CoinManager
@onready var next_coin_label: NextCoinLabel = %NextCoinLabel


func _ready() -> void:
	
	## Wait until the ground is spawned
	await get_tree().physics_frame
	
	##Coins
	await coin_manager.spawn_random_coin()
	
	next_coin_label.next_coin_number = coin_manager.total_coins[-1].number
	next_coin_label.text = str("Find Coin: ", next_coin_label.next_coin_number)

	EventBus.coin_collected.connect(on_coin_collected)
	

func on_coin_collected(number: int) -> void:
	## Check if the coin that is collected is the correct number
	## If it isnt, alert the nearest enemies
	if number != next_coin_label.next_coin_number:
		print("Wrong Number!!! ", number)
		print("Alert, Alert!!!")
	## Chase the player
	## If it is, change the next number to e found to one lest than the previous one
	next_coin_label.next_coin_number = coin_manager.total_coins[-1].number
	print(next_coin_label.next_coin_number)

	
