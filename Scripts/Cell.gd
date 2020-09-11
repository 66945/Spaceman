extends StaticBody2D

var floatUp = false
var rotateRight = false

var locked = true

func _ready():
	$Visual/FloatTween.interpolate_property($Visual/spaceman, "position",
		Vector2(0, -10), Vector2(0, 10), 2.0, Tween.TRANS_SINE)
	$Visual/FloatTween.start()
	
	$Visual/RotateTween.interpolate_property($Visual/spaceman, "rotation",
		deg2rad(-20), deg2rad(-10), 5.0, Tween.TRANS_SINE)
	$Visual/RotateTween.start()
	
	$Visual/Particles2D.emitting = true

func unlock():
	if locked:
		$Visual/Particles2D.emitting = false
		
		$Visual/FloatTween.stop_all()
		$Visual/RotateTween.stop_all()
		
		$Visual/spaceman.visible = false
		
		$CanvasLayer/Label.visible = true
		$CanvasLayer/Tween.interpolate_property($CanvasLayer/Label, "modulate",\
		Color("ffffff"), Color("00ffffff"), 5.0, Tween.EASE_IN)
		$CanvasLayer/Tween.start()
		
		locked = false
		Global.spacemenSaved += 1

func _on_FloatTween_tween_completed(_object, _key):
	floatUp = not floatUp
	
	if floatUp:
		$Visual/FloatTween.interpolate_property($Visual/spaceman, "position",
			Vector2(0, 10), Vector2(0, -10), 2.0, Tween.TRANS_SINE)
	else:
		$Visual/FloatTween.interpolate_property($Visual/spaceman, "position",
		Vector2(0, -10), Vector2(0, 10), 2.0, Tween.TRANS_SINE)
	
	$Visual/FloatTween.start()

func _on_RotateTween_tween_completed(_object, _key):
	rotateRight = not rotateRight
	
	if rotateRight:
		$Visual/RotateTween.interpolate_property($Visual/spaceman, "rotation",
			deg2rad(-20), deg2rad(-10), 5.0, Tween.TRANS_SINE)
	else:
		$Visual/RotateTween.interpolate_property($Visual/spaceman, "rotation",
			deg2rad(-10), deg2rad(-20), 5.0, Tween.TRANS_SINE)
	
	$Visual/RotateTween.start()

func _on_Tween_tween_completed(_object, _key):
	$CanvasLayer/Control.visible = false
	$CanvasLayer/Control.modulate = Color("ffffff")
