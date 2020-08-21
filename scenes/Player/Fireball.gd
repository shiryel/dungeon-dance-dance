extends RigidBody2D

export var target = Vector2()
export var speed = 400

func fireball_hit(body):
	if body is TileMap: # disappears when it hits the walls
		queue_free()
	else: # deletes itself and whatever it hit
		body.queue_free()
		queue_free()
	
