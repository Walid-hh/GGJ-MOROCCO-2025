extends State
class_name BubbleEmpty
@onready var bubble: Area2D = $"../.."
@onready var player: CharacterBody2D = $"../../../../Player"
@onready var player_normal : State = $"../../../../Player/StateMachine/PlayerNormal"
@onready var bubble_spawner: Node2D = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble.body_entered.connect(_slime_entered_bubble)


func _slime_entered_bubble(_body_that_entered : CharacterBody2D) -> void :
	print("slime_entered")
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
func _process(delta: float) -> void:
	pass

func _reparent_bubble() -> void :
	bubble.reparent(player , true)
