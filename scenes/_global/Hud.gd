extends Control

signal dead

func _on_Player_hit():
	$HealthBar.value -= 25
	if $HealthBar.value <= 0: # death
		$UrDead.visible = true
		emit_signal("dead")
