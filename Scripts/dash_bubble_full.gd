extends State
class_name DashBubbleFull
@onready var dash_bubble: Area2D = $"../.."
@onready var player: CharacterBody2D = $"../../../../Player"
@onready var player_in_dash_bubble : State = $"../../../../Player/StateMachine/PlayerInDashBubble"
var collision : KinematicCollision2D
const SPEED := 100.0
const DASH_SPEED := 300.0
var is_dashing := false
var dash_access = true
var direction : Vector2
var dash_timer : Timer

# Called when the node enters the scene tree for the first time.
func enter():
	dash_timer = Timer.new()
	add_child(dash_timer)
	player.playercollision.connect(_on_collision.bind(collision))
	dash_timer.timeout.connect(_dash_access)
	print("dash_bubble full")

func physics_update(_delta : float):
	if !player.is_on_floor():
		player.velocity = Vector2(0 , -2)
		direction.x = Input.get_axis("move_left" , "move_right")
	if Input.is_action_just_pressed("dash") and dash_access == true:
		is_dashing = true
		dash_access = false
		dash_timer.start(0.3)
	if is_dashing : 
		player.velocity.x = direction.x * DASH_SPEED * _delta
	else :
		player.velocity.x = direction.x * SPEED * _delta
	collision = player.move_and_collide(player.velocity)
	if collision :
		player.playercollision.emit()
	
func _on_collision(_collision_that_happened : KinematicCollision2D) -> void :
	Transitioned.emit(self , "DashBubbleEmpty")
	player.playercollision.disconnect(_on_collision.bind(collision))
	player_in_dash_bubble.Transitioned.emit(player_in_dash_bubble , "PlayerNormal")
	dash_bubble.queue_free()

func _dash_access() -> void :
	dash_access = true
	is_dashing = false
	
	
