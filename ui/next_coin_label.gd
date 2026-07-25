class_name NextCoinLabel extends Label

var next_coin_number: int


func _ready() -> void:
	EventBus.next_coin_collected.connect(on_next_coin_collected)

func _process(delta: float) -> void:
	text = str("Find Coin Number: ", next_coin_number)


func on_next_coin_collected() -> void:
	next_coin_number -= 1
