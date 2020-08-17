extends Node2D

var Destination = Vector2()

func _ready():
	$Player.target = $StartingPosition.position

func _input(event): # coloca o X no local onde ele clicou
	if event.is_action_pressed('ui_click'):
		$DestinationMarker.position = get_global_mouse_position()
		Destination = get_global_mouse_position()

func _process(delta): # esconde e resurge o X se ele andou até o local
	if (Destination - $Player.position).length() > 5:
		$DestinationMarker.visible = true
	else:
		$DestinationMarker.visible = false
