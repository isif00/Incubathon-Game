extends KinematicBody2D

export (int) var run_speed = 20
export (int) var jump_speed = -400
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false

var facing_right = true

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var jump = Input.is_action_just_pressed("jump")

	if jump:
		jumping = true
		$AnimationPlayer.play("jumping")
		print("jump")
		velocity.y = jump_speed
		
	elif right:
		facing_right = true
		velocity.x += run_speed
		$AnimationPlayer.play("Run")
	elif left:
		facing_right = false
		velocity.x -= run_speed
		$AnimationPlayer.play("Run")
	else:
		$AnimationPlayer.play("Idle")
		velocity.x = lerp(velocity.x, 0, 0.2)
		

func _physics_process(delta):
	
	if facing_right == true:
		$Sprite.scale.x = 0.194
	else:
		$Sprite.scale.x = -0.194

	velocity.x = clamp(velocity.x, -run_speed, run_speed)
	
	get_input()
	velocity.y += gravity * delta
	
	if jumping:
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
