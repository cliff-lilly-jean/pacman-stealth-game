extends Node

@onready var player = %Player
@onready var pellets = %Pellets
@onready var score = %Score

func _ready() -> void:
	for pellet in pellets.get_children():
		pellet.collected.connect(on_collected)
	
	

func on_collected() -> void:
	score.update_score.emit()
	
