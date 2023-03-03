extends KinematicBody2D



func _on_SwordHit_area_entered(area):
	if area.is_in_group("HitBox"):
		queue_free()
