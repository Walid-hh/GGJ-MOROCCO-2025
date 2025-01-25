extends Node2D

var bubble_scene : PackedScene = preload("res://Scenes/Bubble.tscn")
var dash_bubble_scene : PackedScene = preload("res://Scenes/DashBubble.tscn")  # Preload Bubble2
@onready var bubble: Area2D = $"Bubble"
@onready var dash_bubble: Area2D = $"DashBubble"
var bubble_initial_position : Vector2
var dash_bubble_initial_position : Vector2
var timer : Timer
var timer_started := false


func _ready() -> void:
	bubble_initial_position = bubble.position
	dash_bubble_initial_position = dash_bubble.position
	# Optionally start the timer or any other setup if needed.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_instance_valid(bubble):
			_spawn_bubble()
	if !is_instance_valid(dash_bubble):
			_spawn_dash_bubble()
func _spawn_bubble() -> void:
	# Choose between bubble_scene and bubble2_scene (you can randomize or alternate based on a condition)
	#var selected_bubble_scene : PackedScene = randf_range(0, 1) > 0.5 ? bubble_scene : bubble2_scene
	
	var bubble_instance = bubble_scene.instantiate()
	bubble_instance.position = bubble_initial_position
	add_child(bubble_instance)
	bubble = bubble_instance
	print("bubble spawned")

func _spawn_dash_bubble() -> void :
	var bubble_instance = dash_bubble_scene.instantiate()
	bubble_instance.position = dash_bubble_initial_position
	add_child(bubble_instance)
	dash_bubble = bubble_instance
	print("dash_bubble spawned")
