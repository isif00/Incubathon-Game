extends KinematicBody2D


export (int) var run_speed = 20
export (int) var jump_speed = -400
export (int) var gravity = 1200
export var climbing = false


const ACCELERATION = 100
const FRICTION = 200
var velocity = Vector2.ZERO

var health = 3
var score = 0 

var jumping = false
var runing = false 
var idle = true 
var attack = false 
var death = false 
var get_hit = false 
var facing_right = true	
var on_ladder = false
var can_move = true

var state_machine
var run_animation

var input_vector = Vector2.ZERO



func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	$hurt.visible = false 
	
func get_input():
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")  # set the speed diection	
	var jump_pressed = Input.is_action_just_pressed("jump")
	attack = Input.is_action_just_pressed("shoot")
		
	if input_vector.x > 0 :
		facing_right = true
	elif input_vector.x < 0 :
		facing_right = false
	
	
	if jump_pressed and is_on_floor():
		velocity.y = jump_speed *2 # multiplied by 2 just to be able to jump higher
		jumping= true

func _on_ladder_body_entered(body): # body ==> kinematicBody2D + tileMap
	if body.is_in_group("Climber") and not body.climbing: # only target the player ( who is in climber group )
		body.climbing = true
			
func _on_ladder_body_exited(body):
	if body.is_in_group("Climber") and body.climbing :
			body.climbing = false

func _on_Timer_timeout():
	$Sprite.visible = true  
	$hurt.visible =  false

func _on_HitBox_area_entered(area):
	if area.is_in_group("Sword_Hit"):
		score += 1
		
	if area.is_in_group("HitBox_PLayer"):
		health -= 1	
			
		$Sprite.visible = false 
		$hurt.visible = true 
		$Timer.start()
		
		if health <= 0:
			death = true			
	
func _physics_process(delta):
		
	if score == 1 :
		print("winner")
	
	if facing_right == true:
		$Sprite.scale.x = 0.194
		get_node("SwordHit/CollisionShape2D").position.x = -1.944
	else:
		$Sprite.scale.x = -0.194
		get_node("SwordHit/CollisionShape2D").position.x = -8.056
	
	get_input()
				
	var current_aniamtion = state_machine.get_current_node() 
	
	if climbing:
		on_ladder = true
		velocity.y = 0
		gravity = 0
		input_vector.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
		velocity.y += input_vector.y * 20 
		
	elif not climbing :
		state_machine.travel("jumping")
		gravity = 70
	
	if on_ladder and not climbing :
		velocity.y += -10 *delta
		on_ladder = false
		
	velocity.y += gravity * delta	
	
	
	
	if jumping:
		if not climbing :
			if attack :
				state_machine.travel("hit")
		jumping = false 
	
	else:
		if(input_vector.x != 0 ) and is_on_floor() :
			velocity.x += input_vector.x * ACCELERATION	* delta
			velocity.x = clamp(velocity.x, -run_speed, run_speed)
	
			runing = true
			
			if runing and not attack :
				state_machine.travel("Run")
			elif attack:
				print("attacking !")
				state_machine.travel("hit")
				velocity.x *= -0.5
			elif death: 
				state_machine.travel("death")
				
		elif input_vector.x == 0  :
	
			idle = true
			if idle :
				state_machine.travel("Idle")
				if attack:
					state_machine.travel("hit")
				if death:
					state_machine.travel("death")	
				
			velocity.x = lerp(velocity.x, 0, 1.2)
		else:
			if facing_right:
				velocity.x = 20
			else:
				velocity.x = -20
						
	velocity = move_and_slide(velocity, Vector2(0, -1))


