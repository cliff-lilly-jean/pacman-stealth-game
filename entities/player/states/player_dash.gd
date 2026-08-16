extends State
class_name PlayerDash

@export var player: Player

func enter() -> void:
	print("Dashed")
	var dash_direction: Vector3 = Vector3(player.input_direction.x, 0, player.input_direction.y)
	var dash_velocity: Vector3 = player.get_desired_velocity(dash_direction, player.dash_speed)
		
	player.velocity.x = move_toward(player.velocity.x, dash_velocity.x, player.dash_acceleration)
	player.velocity.z = move_toward(player.velocity.z, dash_velocity.z, player.dash_acceleration)

func physics_update(delta: float) -> void:
	change_state.emit(self, 'playermove')
		
	
func exit() -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.dash_deceleration)
	player.velocity.z = move_toward(player.velocity.z, 0, player.dash_deceleration)
