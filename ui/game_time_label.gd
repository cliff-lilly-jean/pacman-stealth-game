extends Label

@export var game_time_in_seconds: float
@onready var timer: Timer = $Timer

var minutes: int
var seconds: float

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	
	timer.start()

func _process(_delta: float) -> void:
	minutes = int(game_time_in_seconds / 60)
	seconds = game_time_in_seconds - minutes * 60
	text = "%02d:%02d" % [minutes, seconds]

func on_timer_timeout() -> void:
	game_time_in_seconds -= 1
	
	if game_time_in_seconds == 0:
		print("Times up")
