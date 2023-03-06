extends KinematicBody2D

var gravity = 1500
var speed = 600
var max_speed = 1000
var velocity = Vector2.ZERO
var direction = 1
var is_on_ladder = false

var IN = false



func _physics_process(delta):
	
	if is_on_floor():
		velocity.x += speed * direction
		#velocity.x = clamp(velocity.x, -max_speed, max_speed)
		
		#print("on floor")
	if not is_on_floor() and not is_on_ladder:
		velocity.y += gravity
	
		
	if is_on_wall():
		direction *= -1 
		#print("on wall")
	if is_on_ladder :
#		IN = true
		velocity.y -= speed
#	elif not IN:
#		velocity.y -= 60	
	
		
	
	
		
	
	velocity = move_and_slide(velocity*delta, Vector2.UP)
	

func _on_SwordHit_area_entered(area):
	if area.is_in_group("HitBox"):
	
		queue_free()


func _on_lader_body_entered(body):
	if body.is_in_group("Enemy"):
		is_on_ladder = true
		print("enemy collide with ladder")
		
		


func _on_lader_body_exited(body):
	if body.is_in_group("Enemy"):
		is_on_ladder = false
		print("OUT")
		
