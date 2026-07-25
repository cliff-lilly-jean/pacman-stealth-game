extends Node

@onready var player = %Player
@onready var ground: Ground = %Ground
@onready var coin_manager: CoinManager = %CoinManager
@onready var next_coin: NextCoinLabel = %NextCoinLabel


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
	## Subtract x seconds from the Game Time if number is not equal to the Next Coin number
	## Alert Enemies in x radius
	## Chase the Player
	## Change the Next Coin Label messsage
	## Update the Next coin number
	EventBus.next_coin_collected.emit()

	
