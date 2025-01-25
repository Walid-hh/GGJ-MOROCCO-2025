extends Node2D
var bubble_scene : PackedScene = preload("res://Scenes/Bubble.tscn")
@onready var bubble: Area2D = $"Bubble"
var bubble_initial_position : Vector2
var timer : Timer
var timer_started := false
signal bubblefreed
func _ready() -> void:
	bubble_initial_position = bubble.position
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_spawn_bubble)
	bubblefreed.connect(_spawn_timer_start)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if  get_child_count() < 2:
		if timer_started == false :
			_spawn_timer_start()
		else:
			return
		
	
func _spawn_bubble() -> void :
	var bubble_instance = bubble_scene.instantiate()
	bubble_instance.position = bubble_initial_position
	add_child(bubble_instance)
	print("bubble spawned")
	timer_started = false

func _spawn_timer_start() -> void :
	timer.start(1)
	timer_started = true
	
