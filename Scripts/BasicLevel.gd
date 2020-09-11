extends Node2D

var usingXray = false

func _ready():
	$ParallaxBackground/Stars.visible = true
	$ParallaxBackground/Background.visible = true
	$CanvasModulate.visible = true
	
	if Global.lightsOut:
		$ParallaxBackground/ParallaxLayer.visible = true
		$CanvasModulate.color = Color("000000")

func _process(_delta):
	$Camera2D.position.x = int($Player.position.x / 1024) * 1024
	$Camera2D.position.y = int($Player.position.y / 600) * 600
