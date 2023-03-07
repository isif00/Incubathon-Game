extends KinematicBody2D

var gravity = 1500
var speed = 600
var max_speed = 1000
var velocity = Vector2.ZERO
var direction = 1
var is_on_ladder = false


signal hitPlayer 
signal EnemyKilled

	
func _physics_process(delta):
	
	print(is_on_ladder)
	
	
	if is_on_floor():
		velocity.x += speed * direction
		#velocity.x = clamp(velocity.x, -max_speed, max_speed)
		
	if not is_on_floor() and not is_on_ladder:
		velocity.y += gravity
	
		
	if is_on_wall():
		direction *= -1 
	
	if is_on_ladder :
		velocity.y -= speed
		
	
	
	velocity = move_and_slide(velocity*delta, Vector2.UP)
	
func _on_lader_body_entered(body):
	if body.is_in_group("Enemy"):
		is_on_ladder = true
		print("enemy collide with ladder")
		
		
		
func _on_lader_body_exited(body):
	if body.is_in_group("Enemy"):
		is_on_ladder = false
		
		
func _on_HitBox_area_entered(area): 
	if area.is_in_group("HitBox_PLayer"):
		emit_signal("hitPlayer") ## the signal emmited only if Hit_box of enemy
										## entered the Hit_Box_Player
	if area.is_in_group("Sword_Hit"):
		#emit_signal("EnemyKilled")
		queue_free()
	
