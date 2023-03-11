extends StaticBody2D


signal door_opened 

var is_on_location = false 
var is_taken = false 


func _on_Area2D_body_entered(body):
	if is_taken == false:
		is_taken = true
		$key_collected.play()
		$KeyGold.queue_free()
		
		
func _process(delta):
	
	if is_taken == true and is_on_location:
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("door_opened")
				

func _on_Door_body_entered(node: Node):
	if node.is_in_group("Climber"):
		is_on_location = true

#func _on_Door_body_exited(body: PhysicsBody2D):
#	is_on_location = false
#	print(is_on_location)
