extends State
class_name Move

@export var player: Player

func physics_update(delta: float) -> void:
	var direction: Vector3 = Vector3(player.input_direction.x, 0, player.input_direction.y).normalized()
	var move_velocity: Vector3  = player.get_desired_velocity(direction, player.move_speed)
	
	if player.input_direction.length() >= 0.1:
		player.velocity.x = move_toward(player.velocity.x, move_velocity.x,  player.acceleration * delta)
		player.velocity.z = move_toward(player.velocity.z, move_velocity.z, player.acceleration * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.deceleration * delta)
		player.velocity.z = move_toward(player.velocity.z, 0, player.deceleration * delta)

func handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("sprint"):
		change_state.emit(self, 'sprint')
	if Input.is_action_just_pressed("dash"):
		change_state.emit(self, 'dash')
