extends State
class_name PlayerInDashBubble
@onready var player: CharacterBody2D = $"../../../Player"
@onready var dash_bubble: Area2D = $"../../../BubbleSpawner/DashBubble"
@onready var slime_sprite: AnimatedSprite2D = $"../../SlimeSprite"
const SPEED := 100
const DASH_SPEED := 3000
var collision : KinematicCollision2D
var direction : Vector2
var dash_timer : Timer
var dash_access := true

func enter():
	if is_instance_valid(get_node("../../../BubbleSpawner/DashBubble")):
		dash_bubble = get_node("../../../BubbleSpawner/DashBubble")
	print("player in dash bubble")
	player.playercollision.connect(_on_collision.bind(collision))
	slime_sprite.stop()
	slime_sprite.play("Idle")
	dash_timer = Timer.new()
	add_child(dash_timer)
	dash_timer.one_shot = true
	dash_timer.timeout.connect(_dash_access)

func physics_update(_delta : float):
	if !player.is_on_floor():
		player.velocity = Vector2(0 , -1)
	var movement_direction = Input.get_axis("move_left" , "move_right")
	player.velocity.x = movement_direction * SPEED * _delta
	if Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("move_right"):
		direction = Vector2.RIGHT
	if Input.is_action_just_pressed("dash") and dash_access == true :
		_dash(direction , _delta)
	collision = player.move_and_collide(player.velocity)
	if collision :
		player.playercollision.emit()

func _dash(direction : Vector2 , delta : float) -> void :
	player.velocity = direction * DASH_SPEED  * delta
	dash_access = false
	dash_timer.start(0.5)


func _dash_access() -> void :
	player.velocity = Vector2(0 , 0)
	dash_access = true


func _on_collision(_collision_that_happened : KinematicCollision2D) -> void :
	dash_bubble.queue_free()
	player.playercollision.disconnect(_on_collision.bind(collision))
	Transitioned.emit(self , "PlayerNormal")
