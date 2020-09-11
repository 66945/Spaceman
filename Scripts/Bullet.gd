extends KinematicBody2D

const speed = 1000

var direction

#var checked
var moving

func _ready():
	moving = true
	#checked = false
	#$RayCast2D.cast_to = Vector2(1024 * direction, 0)

func _physics_process(delta):
	#if not checked:
	#	if $RayCast2D.get_collider() != null:
	#		var hit = $RayCast2D.get_collision_point()
	#		print(hit)
	#		
	#		position = hit
	#	else:
	#		queue_free()
	#	
	#	checked = true
	if moving:
		var collide = move_and_collide(Vector2(direction, 0) * speed * delta)
		if collide:
			explode()

func explode():
	$Sprite.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	$Particles2D.emitting = true
	$Timer.start()
	
	moving = false

func _on_Hitbox_body_entered(body):
	#print("moo")
	#$Sprite.visible = false
	#$Particles2D.emitting = true
	#$Timer.start()
	explode()
	if body.has_method("kill"):
		body.kill()

func _on_Timer_timeout():
	$Timer.stop()
	queue_free()
