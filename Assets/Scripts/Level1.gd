extends Node2D

var enemy_scene = preload("res://Assets/Scenes/Enemy.tscn")

#func _process(delta):
#	pass


func _on_SpawnTimer_timeout():



# Clone the enemy scene
	var cloned_enemy_scene = enemy_scene.duplicate()

	# Create a new instance of the cloned scene
	var enemy = cloned_enemy_scene.instance()

	# Assign a unique name to the new enemy node
	enemy.set_name("Enemy_" + str(get_tree().get_nodes_in_group("Enemies").size() + 1))


	# Add the new enemy node as a child of the current node
	add_child(enemy)

	$SpawnTimer.stop()
