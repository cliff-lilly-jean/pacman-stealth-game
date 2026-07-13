class_name Stamina extends Node3D

@export var max_stamina: float
@export var recovery_amount: float

var stamina: float

signal stamina_changed(amount: float)

func _ready() -> void:
	stamina = max_stamina
