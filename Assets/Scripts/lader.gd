extends Area2D

signal laderSig



func _on_lader_body_entered(body):
	if body.is_in_group("Enemy"):
		emit_signal("laderSig")
	
	
