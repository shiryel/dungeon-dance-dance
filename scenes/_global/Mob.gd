extends KinematicBody2D

export (int) var speed = 80
var velocity = Vector2()
export var target = Vector2()

func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(RigidBody2D):
	print("help")
	
