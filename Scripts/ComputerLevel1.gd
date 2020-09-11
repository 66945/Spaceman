extends "res://Scripts/Computer.gd"

export (NodePath) var Modulate
export (NodePath) var Background

func _ready():
	Player = get_node(Player)
	Modulate = get_node(Modulate)
	Background = get_node(Background)

func handle(correct):
	if correct and Global.lightsOut:
		Global.lightsOut = false
		
		Player.get_node("Xray").visible = false
		
		Background.visible = false
		Modulate.color = Color("333333")
	
	.handle(correct)
