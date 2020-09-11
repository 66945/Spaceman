extends Sprite

onready var Bullet = load("res://Scenes/Bullet.tscn")

func _process(_delta):
	if Global.hasGun:
		if Input.is_action_just_pressed("shoot"):
			var bullet = Bullet.instance()
			bullet.position = $Position2D.global_position
			bullet.direction = get_parent().scale.x
			
			get_tree().current_scene.add_child(bullet)
