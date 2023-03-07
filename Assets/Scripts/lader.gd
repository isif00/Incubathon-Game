extends Area2D

signal laderSig
signal out_laderSig


func _on_lader_body_entered(body):
	if body.is_in_group("Enemy"):
		emit_signal("laderSig")

func _on_lader_body_exited(body):
	if body.is_in_group("Enemy"):
		emit_signal("out_laderSig")


func _on_lader_area_entered(area):
	pass # Replace with function body.
	

func _on_lader_area_exited(area):
	pass # Replace with function body.
