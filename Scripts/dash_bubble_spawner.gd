extends Node2D

var dash_bubble_scene : PackedScene = preload("res://Scenes/DashBubble.tscn")
@onready var dash_bubble: Area2D = $"DashBubble"
var dash_bubble_initial_position : Vector2
var timer : Timer
var timer_started := false


func _ready() -> void:
	dash_bubble_initial_position = dash_bubble.position
	# Optionally start the timer or any other setup if needed.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_instance_valid(dash_bubble):
			_spawn_dash_bubble()

func _spawn_dash_bubble() -> void:
	# Choose between dash_bubble_scene and dash_bubble2_scene (you can randomize or alternate based on a condition)
	#var selected_dash_bubble_scene : PackedScene = randf_range(0, 1) > 0.5 ? dash_bubble_scene : dash_bubble2_scene
	
	var dash_bubble_instance = dash_bubble_scene.instantiate()
	dash_bubble_instance.position = dash_bubble_initial_position
	add_child(dash_bubble_instance)
	dash_bubble = dash_bubble_instance
	print("dash_bubble spawned")
