extends Sprite

export (String) var CodeWord
export (NodePath) var Unlockable
export (NodePath) var Player

var active

func _ready():
	$CanvasLayer/Screen.codeWord = CodeWord
	Unlockable = get_node(Unlockable)
	
	active = false
	#$CanvasLayer/Screen/TextEdit.text = text

func _process(_delta):
	if active:
		if Input.is_action_just_pressed("interact"):
			$CanvasLayer/Screen.reset()
			$CanvasLayer/Screen.visible = true
			Player.toggle_frozen()
		elif Input.is_action_just_pressed("deinteract"):
			handle($CanvasLayer/Screen.correct)
			$CanvasLayer/Screen.visible = false
			Player.toggle_frozen()

func toggle_active(body, onOff):
	if body.name == "Player":
		Player = body
		active = onOff

func handle(correct):
	if correct:
		Unlockable.unlock()

func _on_Area2D_body_entered(body):
	toggle_active(body, true)

func _on_Area2D_body_exited(body):
	toggle_active(body, false)
