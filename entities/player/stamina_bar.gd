extends TextureProgressBar

@onready var stamina_component: StaminaComponent = %StaminaComponent

func _ready() -> void:
	value = max_value
	max_value = stamina_component.max_stamina
	
	print("This is the stamina: ", value)
	
	Events.stamina_updated.connect(update_stamina_bar)


func update_stamina_bar(stamina_value) -> void:
	value = stamina_value
