extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State
var states: Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.change_state.connect(on_change_state)
			
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func on_change_state(old_state: State, new_state: String) -> void:
	if current_state != old_state:
		return
	
	if current_state:
		current_state.exit()
	
	current_state = states.get(new_state.to_lower())
	
	if current_state:
		current_state.enter()
		
