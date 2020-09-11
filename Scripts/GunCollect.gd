extends Area2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Global.hasGun = true
		body.show_gun()
		queue_free()
