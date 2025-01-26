extends State
class_name PlayerInDashBubble
@onready var player: CharacterBody2D = $"../../../Player"
@onready var dash_bubble: Area2D = $"../../../DashBubbleSpawner/DashBubble"
@onready var slime_sprite: AnimatedSprite2D = $"../../SlimeSprite"


func enter():
	print("player in dash_bubble")
	slime_sprite.stop()
	slime_sprite.play("Idle")

func exit():
	pass

func update(delta : float):
	if !is_instance_valid(dash_bubble):
		Transitioned.emit(self , "PlayerNormal")
