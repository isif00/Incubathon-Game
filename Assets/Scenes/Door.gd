extends Area2D


func _ready():
	$Door_closed.visible = true
	
	
func _on_StaticBody2D_chest_opened():
	$Door_closed.visible = false
	get_tree().change_scene("res://Assets/Scenes/Level_2.tscn")
	
