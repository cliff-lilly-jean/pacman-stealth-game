class_name GameTime extends Node3D

@onready var timer: Timer = $Timer
@onready var label: Label = %Label

var time_in_seconds: int = 0

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)

func on_timer_timeout() -> void:
	time_in_seconds += 1
	var minutes = int(time_in_seconds / 60)
	var seconds = time_in_seconds - minutes * 60
	label.text = "%02d:%02d" % [minutes, seconds]
