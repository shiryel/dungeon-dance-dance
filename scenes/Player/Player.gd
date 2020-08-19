extends KinematicBody2D

export (int) var speed = 250
signal hit
signal castFireball

var target = Vector2()
var velocity = Vector2()

func _input(event):
	if event.is_action_pressed('ui_click'):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)
		$AnimatedSprite.animation = "walk"
		# Sinto q isso é uma gambiarra muito zuada, mas funfa entao whatever
	else:
		$AnimatedSprite.animation = "idle"

func _on_Area2D_body_entered(body):
	emit_signal("hit")
