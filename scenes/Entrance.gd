extends Node2D

var Destination = Vector2()

func _ready():
	$Player.target = $StartingPosition.position
	$Mob.add_collision_exception_with($Player)
	

func _input(event): # coloca o X no local onde ele clicou
	if event.is_action_pressed('ui_click'):
		$DestinationMarker.position = get_global_mouse_position()
		Destination = get_global_mouse_position()

func _process(delta): # esconde e resurge o X se ele andou até o local
	if Destination == Vector2(0, 0):
		$DestinationMarker.visible = false
	elif (Destination - $Player.position).length() > 5:
		$DestinationMarker.visible = true
	else:
		$DestinationMarker.visible = false
	
	$Mob.target = $Player.position # Mob seguir o player
	
	if $HealthBar.value == 0: # death
		$UrDead.visible = true
		$Player.hide()
		$Player.speed = 0 # the player can't move while dead (meio gambiarra)
