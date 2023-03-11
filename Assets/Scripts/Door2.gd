extends StaticBody2D

#var allow_go_to_next_lvl = false

func _ready():
	$Door_close.visible = true
#	$Door_open.visible = false
	
	
func _on_Key_door_opened():

	$door_open_SFX.play()
#	$Door_close.visible = false
#	$Door_open.visible = true
	$Timer.start()
	
	


func _on_Timer_timeout():
	get_tree().change_scene("res://Assets/Scenes/Level_2.tscn")
