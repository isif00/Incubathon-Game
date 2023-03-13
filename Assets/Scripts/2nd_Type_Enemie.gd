extends KinematicBody2D


#var gravity = 1500
var speed = 600
var max_speed = 1000
var velocity = Vector2(600,0)
var direction = 1
#var is_on_ladder = false



func _physics_process(delta):
	
	$AnimationPlayer.play("Idle")
	if is_on_wall():
		direction *= -1 
		$Sprite.scale.x *=-1
	velocity.x += speed * direction

	
	velocity = move_and_slide(velocity*delta, Vector2.UP)
	


#func _on_SwordHit_area_entered(area):
#	if area.is_in_group("HitBox"):
#		print("qmsdfh apfpaefngpae nf")
#		queue_free()
		

func _on_Hit_Box_area_entered(area):
	if area.is_in_group("Sword_Hit"):
		queue_free()
