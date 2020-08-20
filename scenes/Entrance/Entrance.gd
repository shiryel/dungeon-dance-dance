extends Node2D

export (PackedScene) var Mob

var destination = Vector2()
var spawned_mobs = []

func _ready():
	$Player.target = $StartingPosition.position
	randomize()

func _process(delta):
	for mob in spawned_mobs:
		mob.target = $Player.position

func _on_MusicPlayer_miss():
	$MobPath/MobSpawn.offset = randi()
	var mob = Mob.instance()
	call_deferred("add_child_below_node", $MusicPlayer, mob)
	mob.position = $MobPath/MobSpawn.position
	mob.add_collision_exception_with($Player)
	
	spawned_mobs.append(mob)
