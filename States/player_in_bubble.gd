#extends State
#class_name PlayerInBubble
#@onready var player: CharacterBody2D = $"../../../Player"
#@onready var bubble: Area2D = $"../../../BubbleSpawner/Bubble"
#@onready var slime_sprite: AnimatedSprite2D = $"../../SlimeSprite"
#
#
#func enter():
	#print("player in bubble")
	#slime_sprite.stop()
	#slime_sprite.play("Idle")
#
#func exit():
	#pass
#
#func update(delta : float):
	#if !is_instance_valid(bubble):
		#Transitioned.emit(self , "PlayerNormal")
extends State
class_name PlayerInBubble

@onready var player: CharacterBody2D = $"../../../Player"
@onready var bubble: Area2D = $"../../../BubbleSpawner/Bubble"
@onready var slime_sprite: AnimatedSprite2D = $"../../SlimeSprite"

func enter():
	print("Player entered the bubble state")
	slime_sprite.stop()
	slime_sprite.play("Idle")
	connect_turtle_signals()

func exit():
	disconnect_turtle_signals()

func update(delta: float) -> void:
	if !is_instance_valid(bubble):
		Transitioned.emit(self, "PlayerNormal")

# Custom method to pop the bubble
func pop_bubble() -> void:
	print("Bubble popped by turtle!")  # Debug feedback
	if is_instance_valid(bubble):
		bubble.queue_free()  # Remove the bubble
		Transitioned.emit(self, "PlayerNormal")  # Switch back to normal state

# Connect the turtle signals to the bubble-popping logic
func connect_turtle_signals() -> void:
	for turtle in get_tree().get_nodes_in_group("Turtles"):
		if not turtle.is_connected("turtle_hit_player", Callable(self, "pop_bubble")):
			turtle.connect("turtle_hit_player", Callable(self, "pop_bubble"))

# Disconnect the turtle signals when exiting the bubble state
func disconnect_turtle_signals() -> void:
	for turtle in get_tree().get_nodes_in_group("Turtles"):
		if turtle.is_connected("turtle_hit_player", Callable(self, "pop_bubble")):
			turtle.disconnect("turtle_hit_player", Callable(self, "pop_bubble"))
