extends KinematicBody2D


#export ---> we can change the value from the inspector 
export (int) var run_speed = 20
export (int) var jump_speed = -400
export (int) var gravity = 1200
export var climbing = false


const ACCELERATION = 100
const FRICTION = 200
var velocity = Vector2.ZERO

var jumping = false
var runing = false 
var idle = true 
var attack = false 

var state_machine
var run_animation

var input_vector = Vector2.ZERO

func _ready():
	state_machine = $AnimationTree.get("parameters/playback") ## get access to animation tree
	#run_animation = $AnimationPlayer.get_node("res://Assets/Scenes/Level1.tscn::19")



var facing_right = true

func get_input():
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")  # set the speed diection	
	var jump_pressed = Input.is_action_just_pressed("ui_up")
	
	attack = Input.is_action_just_pressed("shoot")
	
		
	if input_vector.x > 0 :
		facing_right = true
	elif input_vector.x < 0 :
		facing_right = false
	
	
	if jump_pressed and is_on_floor():
		velocity.y = jump_speed *2 # multiplied by 2 just to be able to jump higher
		jumping= true


func _on_ladder_body_entered(body): # body ==> kinematicBody2D + tileMap
	if body.is_in_group("Climber"): # only target the player ( who is in climber group )
		print("IN")
		
		
		if not body.climbing :
			body.climbing = true

		
func _on_ladder_body_exited(body):
	if body.is_in_group("Climber"):
		 
		print("OUT ")
		if body.climbing :
			body.climbing = false


func _on_HitBox_area_entered(area):
	if area.is_in_group("Sword_Hit"):
		print("hit !")
		

	
var on_ladder = false

var can_move = true


	
func _physics_process(delta):
		

	
	if facing_right == true:
		$Sprite.scale.x = 0.194
	else:
		$Sprite.scale.x = -0.194
	
		
	get_input()
					
	
	var current_aniamtion = state_machine.get_current_node() 
		## get the current animation state ( from the animationTree ) 
#	print("current animation is : ", current_aniamtion)
			

	if climbing:
		
		on_ladder = true
#		print ("IN")
		velocity.y = 0
		gravity = 0
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		velocity.y += input_vector.y * 20 
		
	elif not climbing :
		state_machine.travel("jumping")
#		print("OUT")
		#velocity.y += gravity * delta
		gravity = 70
	
	if on_ladder and not climbing :
		velocity.y += -10 *delta
		on_ladder = false
		
		
	velocity.y += gravity * delta	
	
	
	
	if jumping:
#		state_machine.set("parameters/Idle/active", false )
		
		if not climbing :
			state_machine.travel("jumping") 
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
				
				
				
		elif input_vector.x == 0  :
	
			idle = true
			if idle :
				state_machine.travel("Idle")
				if attack:
					state_machine.travel("hit")
			
			#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			velocity.x = lerp(velocity.x, 0, 1.2)
		else:
			if facing_right:
				velocity.x = 20
			else:
				velocity.x = -20
						
	velocity = move_and_slide(velocity, Vector2(0, -1))
