class_name StateMachine extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary

func _ready() -> void:
	for child_state: State in get_children():
		child_state.change_state.connect(on_change_state)
		
		## get all the child names and add them to an array
		states[child_state.name.to_lower()] = child_state
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state
	
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_change_state(state: State, next_state_name: String) -> void:
	if state != current_state:
		return
	
	var new_state = states.get(next_state_name.to_lower())
	
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
