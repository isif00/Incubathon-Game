extends StaticBody2D


func _ready():
	$Door_close.visible = true
	
func _on_Key_door_opened():
	print("dsfq sf")
	$Door_close.visible = false
	get_tree().change_scene("res://Assets/Scenes/Level_3.tscn")
