extends Node

@onready var player = %Player
@onready var pellets = %Pellets
@onready var score = %Score

var current_score: int = 0

func _ready() -> void:
	for pellet in pellets.get_children():
		pellet.collected.connect(on_collected)


func on_collected() -> void:
	current_score += 1
	score.text = str(current_score)
