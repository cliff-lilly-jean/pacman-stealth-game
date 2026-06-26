class_name Search extends State

@export var entity: Ghost


## Travels to the targets last known position, Searches by rotating around looking for the target and if the target is not found transitions back into the patrol, If the target is found, it moves back into the chase state
