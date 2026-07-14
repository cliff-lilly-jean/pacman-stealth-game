extends Label

var score: int

signal update_score

func _ready() -> void:
	update_score.connect(on_update_score)

func _process(delta: float) -> void:
	text = "Score: " + str(score)

func on_update_score() -> void:
	score += 1
