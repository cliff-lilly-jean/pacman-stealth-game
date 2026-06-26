class_name StateMachine extends Node


var states: Dictionary = {}
var current_state: State
@export var initial_state: State


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.change_state.connect(on_changed_state)
			
	if initial_state:
		current_state = initial_state
		initial_state.enter()
		

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func on_changed_state(state: State, new_state_name: String) -> void:
	
	## Check if the state is equal to the current state, if not return
	if state != current_state:
		return
	
	## Get the snew state from the dictionary by name
	var new_state = states.get(new_state_name.to_lower())
	
	## If there isnt a new state by that name, return
	if !new_state:
		return
	
	## If we have a current state, exit it
	if current_state:
		current_state.exit()
		
	
	## Make the new state the current state
	current_state = new_state
	
	## enter the new state
	new_state.enter()
	
	
