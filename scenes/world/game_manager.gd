extends Node

@onready var player = %Player
@onready var pellets = %Pellets
@onready var score = %Score
@onready var game_timer: Timer = %GameTimer
@onready var game_time: Label = %GameTime



var time_in_seconds: int = 0

func _ready() -> void:
	## Pellets
	for pellet in pellets.get_children():
		score.total = pellets.get_child_count()
		pellet.collected.connect(on_collected)
		
	## Game timer
	game_timer.timeout.connect(on_timer_timeout)

func on_collected() -> void:
	score.update_score.emit()
	

func on_timer_timeout() -> void:
	time_in_seconds += 1
	var minutes = int(time_in_seconds / 60)
	var seconds = time_in_seconds - minutes * 60
	game_time.text = "%02d:%02d" % [minutes, seconds]
