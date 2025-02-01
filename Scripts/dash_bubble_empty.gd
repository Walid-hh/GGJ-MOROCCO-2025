extends State
class_name DashBubblleEmpty
@onready var dash_bubble: Area2D = $"../.."
@onready var player: CharacterBody2D = $"../../../../Player"
@onready var player_normal : State = $"../../../../Player/StateMachine/PlayerNormal"
@onready var dash_bubble_spawner: Node2D = $"../../.."
@onready var bubble_enter: AudioStreamPlayer = $"../../BubbleEnter"
var dash_bubble_initial_pos : Vector2
var tween : Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dash_bubble.body_entered.connect(_slime_entered_dash_bubble)
	dash_bubble_initial_pos = dash_bubble.position
	tween = create_tween()
	var dash_bubble_offset_y = dash_bubble_initial_pos.y - 5
	tween.tween_property(dash_bubble , "position:y" , dash_bubble_offset_y , 1)
	tween.tween_property(dash_bubble , "position:y" , dash_bubble_initial_pos.y , 1)
	tween.set_loops()

func _slime_entered_dash_bubble(_body_that_entered : CharacterBody2D) -> void :
	print("slime_entered")
	bubble_enter.play()
	tween.kill()
	dash_bubble.position = dash_bubble_initial_pos
	#removing the signal before changing states
	dash_bubble.body_entered.disconnect(_slime_entered_dash_bubble)
	#places the player in the center of the dash_bubble
	player.position = dash_bubble_spawner.position + Vector2(0,-5)
	#making the dash_bubble a child of the player
	call_deferred("_reparent_dash_bubble")
	#changing the state to PlayerInBubble
	Transitioned.emit(self ,"DashBubbleFull")
	player_normal.Transitioned.emit(player_normal , "PlayerInDashBubble")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _reparent_dash_bubble() -> void :
	dash_bubble.reparent(player , true)
