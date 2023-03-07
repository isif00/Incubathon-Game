extends Node2D

var enemy_scene = preload("res://Assets/Scenes/Enemy.tscn")
var enemy 
#func _process(delta):
#	pass


func _on_SpawnTimer_timeout():

	enemy = enemy_scene.instance()
	add_child(enemy)
	enemy.add_to_group("Enemy")
	if enemy.is_in_group("Enemy"):
		print("Enemy added to the 'Enemy' group")
	
#	print(enemy_nodes)
	$SpawnTimer.stop()
