extends CharacterBody2D
class_name Tank

const SPEED = 64.0
const TURN_SPEED = 2
const ROTATE_SPEED = 20

@export var weapon: Weapon

@onready var body_sprite := $BodySprite
@onready var animation_player = $AnimationPlayer
@onready var collider = $CollisionShape2D

# move forward backward left right
var direction := Vector2.RIGHT

func _physics_process(delta):
	var input_direction := Input.get_vector("turn_left", "turn_right", "move_backward", "move_forward")
	# print(input_direction)

	if input_direction.x != 0:
		# rotate direction based on input vector and apply turn speed
		direction = direction.rotated(input_direction.x * (PI / 2) * TURN_SPEED * delta)
		rotation = direction.angle()
	if input_direction.y != 0:
		# Move forward/back and play animation
		animation_player.play("move")
		velocity = lerp(velocity, (direction.normalized() * input_direction.y) * SPEED, SPEED * delta)
	else:
		# bring to a stop
		velocity = Vector2.ZERO
		animation_player.play("idle")
		
	# Apply movement velocity
	move_and_slide()
	
	# Apply weapon rotation
	var weapon_rotate_direction := Input.get_axis("rotate_weapon_left", "rotate_weapon_right")
	weapon.rotation_degrees += (weapon_rotate_direction * ROTATE_SPEED * delta * PI)
		
func _input(event):
	if event.is_action_pressed("weapon_fire"):
		weapon.fire()
