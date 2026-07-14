extends Node

var pellet = Pellet.new()
var score: int = 0

func _ready() -> void:
	pellet.collected.connect(on_collected)


func on_collected() -> void:
	print("Collected")
