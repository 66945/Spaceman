extends RayCast2D

func _ready():
	$Particles2D.emitting = true

func _process(_delta):
	if is_colliding():
		var pos = get_global_transform()[2]
		var dist = (get_collision_point() - pos).length() + 5
		
		$Sprite.scale.y = dist / 64
		$Particles2D.position.y = dist
		
		var col = get_collider()
		
		if col != null:
			if col.name == "Player":
				col.hurt(self)
