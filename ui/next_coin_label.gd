class_name NextCoinLabel extends Label

var next_coin_number: int


func _ready() -> void:
	EventBus.next_coin_collected.connect(on_next_coin_collected)


func on_next_coin_collected(next_number: int) -> void:
	next_coin_number = next_number
	
	text = str(
		"Find Coin Number: ",
		next_coin_number
	)
