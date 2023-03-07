extends KinematicBody2D


var gravity = 1500
var speed = 600
var max_speed = 1000
var velocity = Vector2.ZERO
var direction = -1

signal hitPlayer 
signal EnemyKilled

var ladder_states = {}  # dictionary to store ladder states for each enemy instance

var lader_node

func _ready():
	
	
	
	lader_node = get_tree().get_root().find_node("lader", true, false)
	lader_node.connect("laderSig", self, "_on_ladder_enter")
	lader_node.connect("out_laderSig", self, "_on_ladder_exit")
	ladder_states[get_instance_id()] = false

func _physics_process(delta):
	if ladder_states.get(get_instance_id(), false):
		velocity.y = -speed
	else:
		if is_on_floor():
			velocity.x += speed * direction
			#velocity.x = clamp(velocity.x, -max_speed, max_speed)

		if not is_on_floor() and not ladder_states.get(get_instance_id(), false):
			velocity.y += gravity

		if is_on_wall():
			direction *= -1 
			$PotionGreen.scale.x *= -1

	velocity = move_and_slide(velocity*delta, Vector2.UP)

func _on_ladder_enter():
	ladder_states[get_instance_id()] = false # true 

func _on_ladder_exit():
	ladder_states[get_instance_id()] = false

func _on_HitBox_area_entered(area): 
	if area.is_in_group("HitBox_PLayer"):
		emit_signal("hitPlayer")
	if area.is_in_group("Sword_Hit"):
		queue_free()
