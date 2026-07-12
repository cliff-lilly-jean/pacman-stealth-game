class_name StaminaComponent extends Node3D

@export var max_stamina: float
@export var recovery_amount: float

var stamina: float

signal stamina_changed(amount: float)

func _ready() -> void:
	stamina = max_stamina
	stamina_changed.emit(stamina)

func _process(delta: float) -> void:
	recover(delta)

func drain(amount: float) -> void:
	if stamina < amount:
		return
	
	stamina -= amount
	stamina = clamp(stamina, 0.0, max_stamina)
	stamina_changed.emit(stamina)

func recover(delta: float) -> void:
	if stamina >= max_stamina:
		stamina = max_stamina
	
	stamina += recovery_amount * delta
	stamina = clamp(stamina, 0.0, max_stamina)
	stamina_changed.emit(stamina)	
