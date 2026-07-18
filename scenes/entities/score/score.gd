class_name Score extends Node3D

@export var label: Label

var score: int
var total: int

signal update_score(score_amount)

func _ready() -> void:
	update_score.connect(on_update_score)
	
	label.text = "Score: " + str(score) + " / " + str(total)


func _process(delta: float) -> void:
	label.text = "Score: " + str(score) + " / " + str(total)

func on_update_score(score_amount) -> void:
	score += score_amount
