extends State
class_name PlayerNormal
@onready var player: CharacterBody2D = $"../.."
@onready var bubble: Area2D = $"../../../BubbleSpawner/Bubble"

const SPEED = 100
const JUMP_VELOCITY = -300.0

func enter():
	print(bubble)
	print("normal")
	bubble.body_entered.connect(_slime_entered)
	
func physics_update(delta: float) -> void:
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

	player.move_and_slide()


func _slime_entered(_body_that_entered : CharacterBody2D) -> void :
	print("slime_entered")
	#removing the signal before changing states
	bubble.body_entered.disconnect(_slime_entered)
	#places the player in the center of the bubble
	player.position = bubble.position + Vector2(0,-5)
	#making the bubble a child of the player
	call_deferred("_reparent_bubble")
	#changing the state to PlayerInBubble
	Transitioned.emit(self ,"PlayerInBubble")

func _reparent_bubble() -> void :
	bubble.reparent(player , true)
	
