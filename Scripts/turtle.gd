extends Area2D

signal turtle_hit_player  # Signal to notify collision with the player

# Exported variables for customization
@export var speed: float = 100.0
@export var direction: int = 1
@export var move_range: float = 200.0

# Private variables
var start_position: Vector2
var current_distance: float = 0.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D  # Assuming you have an AnimatedSprite node

# Called when the node enters the scene tree for the first time
#func _ready() -> void:
	#start_position = position
	#connect("body_entered", Callable(self, "_on_turtle_body_entered"))
func _ready() -> void:
	print("Turtle is ready and connecting signal...")
	connect("body_entered", Callable(self, "_on_turtle_body_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	position.x += direction * speed * delta
	current_distance += speed * delta
	
	# Flip the turtle sprite when changing direction
	animated_sprite.flip_h = direction == -1
	
	# Reverse direction when move range is exceeded
	if current_distance >= move_range:
		direction *= -1
		current_distance = 0.0

# Called when the turtle collides with another body
func _on_turtle_body_entered(body: Node) -> void:
	if body.name == "player":  
		print("turtle hit player")
		emit_signal("turtle_hit_player")
		# Optional: Destroy the bubble directly from the turtle script
		if body.has_method("pop_bubble"):  # Assuming the player has a pop_bubble() method
			body.pop_bubble() 
