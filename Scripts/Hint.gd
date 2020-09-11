extends Area2D

export var text = "press k to activate computer"
var checked = false

func _ready():
	$CanvasLayer/Control/Label.text = text

func _on_Hint_body_entered(body):
	if not checked and body.name == "Player":
		checked = true
		$CanvasLayer/Control.visible = true
		$Tween.interpolate_property($CanvasLayer/Control, "modulate",\
		Color("ffffff"), Color("00ffffff"), 5.0, Tween.EASE_IN)
		$Tween.start()

func _on_Tween_tween_completed(_object, _key):
	$CanvasLayer/Control.visible = false
	$CanvasLayer/Control.modulate = Color("ffffff")
