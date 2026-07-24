class_name Coin
extends Area3D

@export var coin_resource: CoinResource
@export var mesh: Node

@onready var audio_stream: AudioStreamPlayer = $AudioStreamPlayer
@onready var destroy_wait_timer: Timer = $DestroyWaitTimer
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var label: Label = %Label


func _ready() -> void:
	body_entered.connect(on_body_entered)
	destroy_wait_timer.timeout.connect(on_timeout)

func _process(delta: float) -> void:
	rotation.y += 6 * delta

func on_body_entered(body: Node3D) -> void:
	if body is Player:
		audio_stream.play()
		EventBus.coin_collected.emit(coin_resource.value)
		destroy_wait_timer.start()
		
		## hide the collision shappe and the mesh
		collision_shape.hide()
		mesh.hide()

func on_timeout() -> void:
	## delete the game object after the timer is done
	queue_free()
