extends KinematicBody2D

export (int) var speed = 80
var velocity = Vector2()
var target = Vector2()

func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)
