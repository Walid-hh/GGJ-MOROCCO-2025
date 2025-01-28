extends State
class_name BubbleEmpty
@onready var bubble: Area2D = $"../.."
@onready var player: CharacterBody2D = $"../../../../Player"
@onready var player_normal : State = $"../../../../Player/StateMachine/PlayerNormal"
@onready var bubble_spawner: Node2D = $"../../.."
var tween : Tween
var bubble_initial_pos : Vector2
# Called when the node enters the scene tree for the first time.
func enter():
	bubble.body_entered.connect(_slime_entered_bubble)
	bubble_initial_pos = bubble.position
	tween = create_tween()
	var bubble_offset_y = bubble_initial_pos.y - 5
	tween.tween_property(bubble , "position:y" , bubble_offset_y , 1)
	tween.tween_property(bubble , "position:y" , bubble_initial_pos.y , 1)
	tween.set_loops()
	
func _slime_entered_bubble(_body_that_entered : CharacterBody2D) -> void :
	print("slime_entered")
	tween.kill()
	bubble.position = bubble_initial_pos
	#removing the signal before changing states
	bubble.body_entered.disconnect(_slime_entered_bubble)
	#places the player in the center of the bubble
	player.position = bubble_spawner.position + Vector2(0,-5)
	#making the bubble a child of the player
	call_deferred("_reparent_bubble")
	#changing the state to PlayerInBubble
	Transitioned.emit(self ,"BubbleFull")
	player_normal.Transitioned.emit(player_normal , "PlayerInBubble")

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _reparent_bubble() -> void :
	bubble.reparent(player , true)
