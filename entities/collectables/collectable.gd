class_name Collectable extends Area3D

@export var category: CollectableCategory
@export var title: String
@export var icon: Sprite2D

signal collected


enum CollectableCategory {
	Currency,
	Item,
	Cosmetic,
	Lore
}


func _ready() -> void:
	## Set the default title of the collectable
	title = name

	
