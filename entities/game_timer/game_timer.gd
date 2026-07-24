class_name GameTimer extends Node3D

@export var label: Label
@export var game_time_in_seconds: float
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)

func on_timer_timeout() -> void:
	game_time_in_seconds -= 1
	var minutes = int(game_time_in_seconds / 60)
	var seconds = game_time_in_seconds - minutes * 60
	label.text = "%02d:%02d" % [minutes, seconds]
	
	if game_time_in_seconds == 0:
		print("Times up")
