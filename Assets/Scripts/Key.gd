extends StaticBody2D


signal door_opened 

var is_on_location = false 
var is_taken = false 


func _on_Area2D_body_entered(body):
	if is_taken == false:
		is_taken = true
		print("is taken")
		$KeyGold.queue_free()
		
func _process(delta):
	if is_taken == true:
		if Input.is_action_just_pressed("shoot"):
			print("qpsifd qsodf")
			emit_signal("door_opened")
				
			

func _on_Door_body_entered(body: PhysicsBody2D):
	is_on_location = true
	print("sifoooooo", is_on_location)
	print(is_on_location)


func _on_Door_body_exited(body: PhysicsBody2D):
	is_on_location = false
	print(is_on_location)
