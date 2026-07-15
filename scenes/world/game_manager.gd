extends Node

@onready var player = %Player
@onready var pellets = %Pellets
@onready var score = %Score

var game_clock: int


func _ready() -> void:
	for pellet in pellets.get_children():
		score.total = pellets.get_child_count()
		pellet.collected.connect(on_collected)
	

func _process(delta: float) -> void:
	game_clock += 1 * delta
	print(game_clock)

func on_collected() -> void:
	score.update_score.emit()
	
