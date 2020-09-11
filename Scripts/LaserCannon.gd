extends StaticBody2D

const speed = 20
const limit = 45

var dir = -1
var dead = false

func _process(delta):
	if not dead:
		$Visual/Blaster.rotation_degrees += dir * speed * delta
		
		if $Visual/Blaster.rotation_degrees <= -limit:
			dir = 1
		elif $Visual/Blaster.rotation_degrees >= limit:
			dir = -1

func kill():
	if not dead:
		$Visual/Blaster.queue_free()
		$Visual/Particles2D.emitting = true
		dead = true
