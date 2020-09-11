extends KinematicBody2D

const MAX_LEFT_RIGHT = 150
const ACCELERATION = 500

var velocity
export var direction = 1

func _ready():
	velocity = Vector2.ZERO
	
	$Visual/AnimationPlayer.play("Move")

func _physics_process(delta):
	$Visual.scale = Vector2.ONE
	
	velocity += Vector2.DOWN * Global.GRAV * delta
	
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().name != "Player":
			direction *= -1
	
	$RayCast2D.cast_to = Vector2(50, 0) * direction
	
	velocity.x += direction * ACCELERATION * delta
	velocity.x = clamp(velocity.x, -MAX_LEFT_RIGHT, MAX_LEFT_RIGHT)
	
	$Visual.scale.x = -direction
	
	velocity = move_and_slide(velocity, Vector2.UP)

func bounce():
	$Visual.SquashStretch = 0.5

func kill():
	queue_free()
