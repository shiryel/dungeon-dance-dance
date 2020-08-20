extends KinematicBody2D

export (PackedScene) var Fireball

export (int) var speed = 250
signal hit

var target = Vector2()
var velocity = Vector2()

func _physics_process(_delta):
	velocity = (target - position).normalized() * speed
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)
		$AnimatedSprite.animation = "walk"
	else:
		$AnimatedSprite.animation = "idle"

func _process(delta):
	if Input.is_action_pressed('ui_mouse_left'):
		target = get_global_mouse_position()

	if Input.is_action_just_pressed('ui_mouse_right'): # fireballs
		var fireball = Fireball.instance()
		fireball.linear_velocity = get_global_mouse_position() - position
		add_child(fireball)

func _on_Area2D_body_entered(body):
	$Control/HealthBar.value -= 25
	if $Control/HealthBar.value <= 0: # death
		print("IM DEAD")
		$Control/UrDead.visible = true
		$AnimatedSprite.hide()
		speed = 0 # the player can't move while dead (meio gambiarra)