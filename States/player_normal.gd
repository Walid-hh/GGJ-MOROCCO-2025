extends State
class_name PlayerNormal
@onready var player: CharacterBody2D = $"../.."
@onready var slime_sprite: AnimatedSprite2D = $"../../SlimeSprite"
@onready var bubble: Area2D = $"../../../BubbleSpawner/Bubble"
@onready var turtle: CharacterBody2D = $"../../../turtle"
@onready var ray_cast_2d: RayCast2D = $"../../RayCast2D"

#@onready var dash_bubble: Area2D = $"../../../BubbleSpawner/DashBubble"
const ACCELERATION = 1000
const DECELERATION = 1000
const SPEED = 200
const JUMP_VELOCITY = -300.0
var desired_velocity : Vector2
var collision : KinematicCollision2D
var is_on_floor : bool = false
func enter():
	print("normal")

func physics_update(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor:
		player.velocity += player.get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor:
		slime_sprite.pause()
		player.velocity.y = JUMP_VELOCITY
		slime_sprite.play("jump")
		is_on_floor = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	desired_velocity.x = direction * SPEED
	if direction:
		player.velocity.x = move_toward(player.velocity.x, desired_velocity.x, ACCELERATION * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, DECELERATION * delta)

	collision = player.move_and_collide(player.velocity * delta)
	if collision:
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		player.velocity = player.velocity.slide(normal)
	if ray_cast_2d.is_colliding() :
		is_on_floor = true
		slime_sprite.play("Idle")
	else :
		is_on_floor = false
#func update(delta : float):
	#for child in get_node("../../../BubbleSpawner").get_children():
		#if child.name.begins_with("Bubble") and bubble == null:
			#bubble = child
			#print("New bubble: ", bubble.name)
		#bubble.body_entered.connect(_slime_entered_bubble)
	#for child in get_node("../../../BubbleSpawner").get_children():
		#if child.name.begins_with("DashBubble") and dash_bubble == null:
			#dash_bubble = child
			#print("New dash_bubble: ", dash_bubble.name)
		#dash_bubble.body_entered.connect(_slime_entered_dash_bubble)
		
#func _slime_entered_bubble(_body_that_entered : CharacterBody2D) -> void :
	#print("slime_entered")
	##removing the signal before changing states
	#bubble.body_entered.disconnect(_slime_entered_bubble)
	##places the player in the center of the bubble
	#player.position = bubble.position + Vector2(0,-5)
	##making the bubble a child of the player
	#call_deferred("_reparent_bubble")
	##changing the state to PlayerInBubble
	#Transitioned.emit(self ,"PlayerInBubble")

#func _slime_entered_dash_bubble(_body_that_entered : CharacterBody2D) -> void :
	#print("slime_entered")
	#dash_bubble.body_entered.disconnect(_slime_entered_dash_bubble)
	#player.position = dash_bubble.position + Vector2(0,-5)
	#call_deferred("_reparent_dash_bubble")
	#Transitioned.emit(self ,"PlayerInDashBubble")
#
#
##func _reparent_bubble() -> void :
	##bubble.reparent(player , true)
#
#func _reparent_dash_bubble() -> void :
	#dash_bubble.reparent(player , true)
