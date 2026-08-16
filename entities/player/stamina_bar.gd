extends TextureProgressBar

@onready var stamina_component: StaminaComponent = %StaminaComponent

func ready() -> void:
	value = max_value
	max_value = stamina_component.max_stamina
	
	Events.stamina_updated.connect(update_stamina_bar)


func update_stamina_bar(stamina_value) -> void:
	value = stamina_value
