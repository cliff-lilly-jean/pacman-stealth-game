extends Node

@onready var player = %Player
@onready var coins: Node3D = %Coins
@onready var score_label: Label = %ScoreLabel
@onready var game_timer: Timer = %GameTimer
@onready var game_time_label: Label = %GameTimeLabel

var time_in_seconds: int = 0
var score_value: int

func _ready() -> void:
	
	## Game timer
	game_timer.timeout.connect(on_timer_timeout)
	
	## Pellets
	for coin in coins.get_children():
		score_label.total = coins.get_child_count()
		
		if coin is Coin:
			score_value = coin.value
		## Coin collected signal
		coin.collected.connect(on_collected)

func on_collected() -> void:
	score_label.update_score.emit(score_value)

func on_timer_timeout() -> void:
	time_in_seconds += 1
	var minutes = int(time_in_seconds / 60)
	var seconds = time_in_seconds - minutes * 60
	game_time_label.text = "%02d:%02d" % [minutes, seconds]
	
