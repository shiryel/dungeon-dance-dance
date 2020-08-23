extends KinematicBody2D

export (PackedScene) var Fireball

export (int) var speed = 250
signal hit
signal dead

var target = Vector2()
var velocity = Vector2()
var dead = false

func _physics_process(_delta): # movement
	velocity = (target - position).normalized() * speed
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)
		$AnimatedSprite.animation = "walk"
	else:
		$AnimatedSprite.animation = "idle"

func _process(_delta):
	if Input.is_action_pressed('ui_mouse_left'): # sets target for movement
		target = get_global_mouse_position()

	if Input.is_action_just_pressed('ui_mouse_right') and not dead: # fireballs
		var fireball = Fireball.instance()
		fireball.position = position
		fireball.linear_velocity = get_global_mouse_position() - position
		get_parent().add_child(fireball)

func _on_Area2D_body_entered(_body):
	emit_signal("hit")

func _on_Hud_dead():
	$AnimatedSprite.hide()
	$SkullAndBones.visible = true
	emit_signal("dead")
	dead = true
	speed = 0 # the player can't move while dead (meio gambiarra)
