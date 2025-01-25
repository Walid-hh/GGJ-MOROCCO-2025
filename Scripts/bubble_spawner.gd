extends Node2D

var bubble_scene : PackedScene = preload("res://Scenes/Bubble.tscn")
var bubble2_scene : PackedScene = preload("res://Scenes/bubble2.tscn")  # Preload Bubble2
@onready var bubble: Area2D = $"Bubble"

var bubble_initial_position : Vector2
var timer : Timer
var timer_started := false
var bubble_spawned := false

func _ready() -> void:
	bubble_initial_position = bubble.position
	# Optionally start the timer or any other setup if needed.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_instance_valid(bubble):
		if bubble_spawned == false:
			_spawn_bubble()

# Function to randomly or conditionally switch between Bubble and Bubble2
func _spawn_bubble() -> void:
	# Choose between bubble_scene and bubble2_scene (you can randomize or alternate based on a condition)
	#var selected_bubble_scene : PackedScene = randf_range(0, 1) > 0.5 ? bubble_scene : bubble2_scene
	var selected_bubble_scene : PackedScene = bubble_scene if randf_range(0, 1) > 0.5 else bubble2_scene

	var bubble_instance = selected_bubble_scene.instantiate()
	bubble_instance.position = bubble_initial_position
	add_child(bubble_instance)
	bubble = bubble_instance
	bubble_spawned = true  # Mark that the bubble is spawned
	print("bubble spawned")
