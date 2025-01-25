extends State
class_name PlayerInBubble
@onready var player: CharacterBody2D = $"../.."
@onready var bubble: Area2D = $"../../../BubbleSpawner/Bubble"
const SPEED := 100.0
var collision : KinematicCollision2D

func enter():
	print("player in bubble")
	player.playercollision.connect(_on_collision.bind(collision))
func exit():
	pass

func update(_delta : float):
	pass

func physics_update(_delta : float):
	if !player.is_on_floor():
		player.velocity.y = -1
	var direction = Input.get_axis("move_left" , "move_right")
	player.velocity.x = direction * SPEED * _delta
	
	collision = player.move_and_collide(player.velocity)
	if collision :
		player.playercollision.emit()

func _on_collision(_collision_that_happened : KinematicCollision2D) -> void :
	bubble.queue_free()
	player.playercollision.disconnect(_on_collision.bind(collision))
	Transitioned.emit(self , "PlayerNormal")
