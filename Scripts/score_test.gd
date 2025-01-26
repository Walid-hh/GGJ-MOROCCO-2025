extends Control
@onready var label: Label = $Label
@onready var player: CharacterBody2D = $"../Player"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(player.score)
