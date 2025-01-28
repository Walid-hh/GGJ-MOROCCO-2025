extends Area2D

# Declare the signal
signal hit_player  

# Exported variables for customization
@export var speed: float = 100.0
@export var direction: Vector2 = Vector2.LEFT
@export var move_range: float = 200.0

# Private variables
var start_position: Vector2
var current_distance: float = 0.0

func _ready() -> void:
	start_position = position
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta: float) -> void:
	position += direction * speed * delta
	current_distance += speed * delta
	if current_distance >= move_range:
		direction *= -1  # Reverse direction
		current_distance = 0.0

func _on_body_entered(body: Node) -> void:
	if body.name == "player":
		emit_signal("hit_player")
