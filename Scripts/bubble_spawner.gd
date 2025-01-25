extends Node2D
var bubble_scene : PackedScene = preload("res://Scenes/Bubble.tscn")
@onready var bubble: Area2D = $"Bubble"
var bubble_initial_position : Vector2
var timer : Timer
var timer_started := false
var bubble_spawned := false
func _ready() -> void:
	bubble_initial_position = bubble.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_instance_valid(bubble):
		if bubble_spawned == false:
			_spawn_bubble()
	
func _spawn_bubble() -> void :
	var bubble_instance = bubble_scene.instantiate()
	bubble_instance.position = bubble_initial_position
	add_child(bubble_instance)
	print("bubble spawned")
	bubble_spawned = true



	
