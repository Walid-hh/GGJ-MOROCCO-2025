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



func update(delta: float) -> void:
	if !is_instance_valid(bubble):
		Transitioned.emit(self, "PlayerNormal")
