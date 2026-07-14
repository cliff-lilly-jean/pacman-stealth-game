class_name Pellet extends Area3D

signal collected

func _ready() -> void:
	body_entered.connect(on_body_entered)

func _process(delta: float) -> void:
	rotation.y += 6 * delta

func on_body_entered(body: Node3D) -> void:
	if body is Player:
		collected.emit()
		queue_free()
