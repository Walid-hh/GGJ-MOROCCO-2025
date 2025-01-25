extends State
class_name PlayerInDashBubble
@onready var player: CharacterBody2D = $"../../../Player"
@onready var dash_bubble: Area2D = $"../../../BubbleSpawner/DashBubble"
@onready var slime_sprite: AnimatedSprite2D = $"../../SlimeSprite"
const SPEED := 100
var collision : KinematicCollision2D

func enter():
	if is_instance_valid(get_node("../../../BubbleSpawner/DashBubble")):
		dash_bubble = get_node("../../../BubbleSpawner/DashBubble")
	print("player in dash bubble")
	player.playercollision.connect(_on_collision.bind(collision))
	slime_sprite.stop()
	slime_sprite.play("Idle")

func physics_update(_delta : float):
	if !player.is_on_floor():
		player.velocity.y = 0
	if Input.is_action_just_pressed("move_left") :
		var dash_direction := Vector2(-1 , 0)
		player.position += dash_direction * SPEED * _delta
		dash_direction = Vector2(0 , 0)
	collision = player.move_and_collide(player.velocity)
	if collision :
		player.playercollision.emit()

func _on_collision(_collision_that_happened : KinematicCollision2D) -> void :
	dash_bubble.queue_free()
	player.playercollision.disconnect(_on_collision.bind(collision))
	Transitioned.emit(self , "PlayerNormal")
