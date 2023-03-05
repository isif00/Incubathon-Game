extends StaticBody2D


signal chest_opened

var is_on_location = false 
var key_taken = false 

func _on_Area2D_body_entered(_body: PhysicsBody2D):
	if key_taken == false:
		key_taken = true 
		$KeyGold.queue_free()

func _process(delta):
	if key_taken:
		if is_on_location:
			if Input.is_action_just_pressed("shoot"):
				print("opened")
				emit_signal("chest_opened")
				


func _on_Door_body_entered(body: PhysicsBody2D):
	is_on_location = true
	print(is_on_location)


func _on_Door_body_exited(body: PhysicsBody2D):
	is_on_location = false
	print(is_on_location)

