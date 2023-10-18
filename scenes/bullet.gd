extends Area2D
class_name Bullet

const SPEED = 500

var direction: Vector2 = Vector2()

func _physics_process(delta):
	position += direction.normalized() * SPEED * delta
