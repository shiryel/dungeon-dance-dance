extends Node2D

export (PackedScene) var Mob
export (PackedScene) var Fireball

var destination = Vector2()
var spawned_mobs = []

func _ready():
	$Player.target = $StartingPosition.position
	$MobTimerTest.start() # deletar dps e arrumar esse spawn
	randomize()
	
func _input(event):
	if event.is_action_pressed('ui_click'): # player's destination marker
		$DestinationMarker.position = get_global_mouse_position()
		destination = get_global_mouse_position()
		
	if event.is_action_pressed('ui_click2'): # fireballs
		var fireball = Fireball.instance()
		fireball.position = $Player.position
		fireball.target = get_global_mouse_position()
		fireball.linear_velocity = Vector2(fireball.target - $Player.position)
		add_child(fireball)
		
func _process(delta):
	if destination == Vector2(0, 0): # destination hiding
		$DestinationMarker.visible = false
	elif (destination - $Player.position).length() > 5:
		$DestinationMarker.visible = true
	else:
		$DestinationMarker.visible = false
		
	if $HealthBar.value == 0: # death
		$UrDead.visible = true
		$Player.hide()
		$Player.speed = 0 # the player can't move while dead (meio gambiarra)
		
	for mob in spawned_mobs:
		mob.target = $Player.position
		
		
func MobSpawn():
	$MobPath/MobSpawn.offset = randi()
	var mob = Mob.instance()
	mob.position = $MobPath/MobSpawn.position
	mob.add_collision_exception_with($Player)
	add_child(mob)
	spawned_mobs.append(mob)
	
