extends KinematicBody2D

const MAX_LEFT_RIGHT = 200
const ACCELERATION = 500

onready var JetpackFlame = load("res://Scenes/JetpackFlame.tscn")
onready var Dust = load("res://Scenes/Dust.tscn")

#export var squish = 1.0

var lives = 3
var hurtable = true

var frozen = false
var velocity = Vector2.ZERO
var jumpNum = 0
var landed = true

func _ready():
	if Global.hasGun:
		show_gun()
	
	if Global.currentLevelNum != null and Global.lightsOut:
		$Xray/Timer.start()
	else:
		$Xray.queue_free()

func _physics_process(delta):
	var move = false
	
	velocity += Vector2.DOWN * Global.GRAV * delta
	
	if not frozen:
		handle_jump()
	
	handle_bounce()
	
	if not frozen and Input.is_action_pressed("ui_left"):
		if velocity.x > 0:
			velocity.x = 0
		velocity.x -= ACCELERATION * delta
		move = true
	elif not frozen and Input.is_action_pressed("ui_right"):
		if velocity.x < 0:
			velocity.x = 0
		velocity.x += ACCELERATION * delta
		move = true
	else:
		if velocity.x != 0:
			velocity.x -= ACCELERATION * (velocity.x / abs(velocity.x)) * delta
			if abs(velocity.x) < 10:
				velocity.x = 0
	
	velocity.x = clamp(velocity.x, -MAX_LEFT_RIGHT, MAX_LEFT_RIGHT)
	
	if velocity.x < 0:
		$Visual.scale.x = -1
	elif velocity.x > 0:
		$Visual.scale.x = 1
	else:
		$Visual.scale.x /= abs($Visual.scale.x)
	
	if not landed and is_on_floor():
		var dust = Dust.instance()
		dust.position = $Visual/DustPos.position
		$Visual.add_child(dust)
		
		$Visual.SquashStretch = 0.5
		
		landed = true
	
	if velocity.y > 400:
		landed = false
	else:
		landed = true
	
	if move and is_on_floor():
		if not $Visual/AnimationPlayer.is_playing():
			$Visual/AnimationPlayer.play("Walk")
	
	velocity = move_and_slide(velocity, Vector2.UP)

func toggle_frozen():
	frozen = not frozen

func show_gun():
	$Visual/Gun.visible = true
	$Visual/backarm.rotation_degrees = -102

func handle_jump():
	if jumpNum < 2 and is_on_floor():
		jumpNum = 2
	if Input.is_action_just_pressed("ui_up") and jumpNum > 0:
		if not is_on_floor():
			var flame = JetpackFlame.instance()
			flame.position = $Visual/JetpackPos.position
			$Visual.add_child(flame)
		
		velocity.y -= 300
		jumpNum -= 1
		
		$Visual.SquashStretch = 1.2

func handle_bounce():
	for node in $Node2D.get_children():
		if node.is_colliding():
			
			if node.get_collider().has_method("bounce"):
				node.get_collider().bounce()
			
			velocity += Vector2.UP * 400
			jumpNum = 2

func hurt(body):
	if body.name != name and hurtable:
		$ref.scale = $Visual.scale
		
		$Visual.material.set_shader_param("hurt", true)
		
		$Hitzone/CollisionShape2D.set_deferred("disabled", true)
		hurtable = false
		
		$Hitzone/FlashTimer.start()
		$Hitzone/HitTimer.start()

func _on_Hitzone_body_entered(body):
	hurt(body)

func _on_Timer_timeout():
	$Xray/Timer.stop()
	$Xray.visible = true
	$Xray/Tween.interpolate_property($Xray/Light2D, "scale", Vector2.ZERO, Vector2(0.0024, 0.0024), 1)
	$Xray/Tween.start()

func _on_FlashTimer_timeout():
	$Hitzone/FlashTimer.stop()
	
	$Visual.material.set_shader_param("hurt", false)

func _on_HitTimer_timeout():
	$Hitzone/HitTimer.stop()
	
	lives -= 1
	if lives <= 0:
		print(get_tree().reload_current_scene())
	else:
		$Hitzone/CollisionShape2D.set_deferred("disabled", false)
		hurtable = true
