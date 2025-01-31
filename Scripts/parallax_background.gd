extends ParallaxBackground

@export var scroll_speed: float = 100.0  # Adjust speed as needed

func _process(delta):
	scroll_offset.x -= scroll_speed * delta  # Moves background to the left
