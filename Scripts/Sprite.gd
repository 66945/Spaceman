extends Sprite

func _process(delta):
	squash_stretch(abs($Position2D.position.y)/64)

func squash_stretch(fac):
	if fac != 0:
		scale = Vector2(1/fac, fac)
