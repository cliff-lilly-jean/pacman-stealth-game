class_name Score extends Node3D

@export var label: Label

var current_points: int
var total_points: int
var total: int

func _ready() -> void:
	EventBus.score_updated.connect(on_score_updated)
	label.text = "Score: " + str(current_points) + " / " + str(total_points)

func _process(_delta: float) -> void:
	label.text = "Point Total: " + str(current_points) + " / " + str(total_points) + " Total Coins: " + str(total)

func on_score_updated(amount) -> void:
	current_points += amount
