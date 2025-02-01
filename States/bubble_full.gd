extends State
class_name BubbleFull
@onready var bubble: Area2D = $"../.."
@onready var player: CharacterBody2D = $"../../../../Player"
@onready var player_in_bubble : State = $"../../../../Player/StateMachine/PlayerInBubble"
@onready var bubble_pop: AudioStreamPlayer = $"../../BubblePop"
var collision : KinematicCollision2D
const SPEED := 100.0
# Called when the node enters the scene tree for the first time.
func enter():
	player.playercollision.connect(_on_collision.bind(collision))
	print("bubble full")
	

func physics_update(_delta : float):
	if !player.is_on_floor():
		player.velocity.y = -2
	var direction = Input.get_axis("move_left" , "move_right")
	player.velocity.x = direction * SPEED * _delta
	collision = player.move_and_collide(player.velocity)
	if collision :
		player.playercollision.emit()
	
func _on_collision(_collision_that_happened : KinematicCollision2D) -> void :
	bubble_pop.play()
	Transitioned.emit(self , "BubbleEmpty")
	player.playercollision.disconnect(_on_collision.bind(collision))
	player_in_bubble.Transitioned.emit(player_in_bubble , "PlayerNormal")
	bubble.queue_free()

	
