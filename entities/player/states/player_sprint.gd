extends State
class_name PlayerSprint

@export var player: Player

func physics_update(delta: float) -> void:
	if Input.is_action_pressed("sprint"):
		
		var sprint_direction: Vector3 = Vector3(player.input_direction.x, 0, player.input_direction.y).normalized()
		var sprint_velocity: Vector3 = player.get_desired_velocity(sprint_direction, player.sprint_speed)
		
		player.velocity.x = move_toward(player.velocity.x, sprint_velocity.x,  player.sprint_acceleration)
		player.velocity.z = move_toward(player.velocity.z, sprint_velocity.z , player.sprint_acceleration)
		
		print("Sprinting")
	else:
		change_state.emit(self, 'playermove')
	
func exit() -> void:
		player.velocity.x = move_toward(player.velocity.x, 0, player.sprint_deceleration)
		player.velocity.z = move_toward(player.velocity.z, 0, player.sprint_deceleration)

func handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("dash"):
		change_state.emit(self, 'playerdash')
	
