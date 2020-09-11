extends Node2D

export var SquashStretch = 1.0
export var SpriteHeight = 0
export var FluxAmount = 0.0

var idleVal = 1.0

func _ready():
	SpriteHeight /= 2
	
	$Tween.interpolate_property(self, "idleVal", -FluxAmount / 2, FluxAmount / 2, 1, Tween.TRANS_LINEAR)
	$Tween.start()

func _process(_delta):
	SquashStretch = lerp(SquashStretch, 1.0, 0.1)
	if SquashStretch < 1.01 and SquashStretch > 0.99:
		SquashStretch = 1
	
	scale.y = 1
	scale *= Vector2(2 - (SquashStretch - abs(idleVal)), SquashStretch - abs(idleVal))
	
	position.y = -(scale.y - 1.0) * SpriteHeight
