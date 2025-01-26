extends CharacterBody2D
signal playercollision
@onready var ui: Control = $"../UI"

var initial_y_position : float
var score = 0
func _ready() -> void:
	initial_y_position = position.y

func _process(delta: float) -> void:
	var height_diff = (initial_y_position - position.y) * 100
	score = int(height_diff)
