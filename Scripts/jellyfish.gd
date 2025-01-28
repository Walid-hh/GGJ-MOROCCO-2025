extends Area2D

signal jellyfish_hit_player  # Declare the signal after extends

# Exported variables
export var speed: float = 100.0
export var direction: int = 1
export var move_range: float = 200.0

# Private variables
var start_position: Vector2
var current_distance: float = 0.0

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	start_position = position
	connect("body_entered", self, "_on_jellyfish_body_entered")

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	position.x += direction * speed * delta
	current_distance += speed * delta
	if current_distance >= move_range:
		direction *= -1
		current_distance = 0.0

# Called when the jellyfish collides with another body
func _on_jellyfish_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):  # Check if the body belongs to the "Player" group
		emit_signal("jellyfish_hit_player")  # Emit the signal when the player collides
