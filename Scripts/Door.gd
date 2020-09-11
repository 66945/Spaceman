extends Area2D

export (int) var LevelNum

var locked = true

func _ready():
	if LevelNum in Global.levels.keys():
		locked = Global.levels[LevelNum]["locked"]
	
	$Sprite.material = $Sprite.material.duplicate()
	
	if locked:
		$StaticBody2D2/CollisionShape2D.set_deferred("disabled", false)
		$Sprite.position.x = 0
		$light.frame_coords.y = 2

func _process(_delta):
	$Sprite.material.set_shader_param("percent", 1 - ($Sprite.position.x/64))

func unlock():
	if locked and LevelNum in Global.levels.keys():
		$StaticBody2D2/CollisionShape2D.set_deferred("disabled", true)
		$AnimationPlayer.play("Open")
		
		Global.levels[LevelNum]["locked"] = false
		locked = false

func _on_Door_body_entered(body):
	if body.name == "Player":
		$StaticBody2D2/CollisionShape2D.set_deferred("disabled", false)
		$AnimationPlayer.play("Close")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Close":
		$light.frame_coords.y = 0
		$Timer.start()
	elif anim_name == "Open":
		$light.frame_coords.y = 1

func _on_Timer_timeout():
	$Timer.stop()
	
	if LevelNum in Global.levels.keys():
		#if LevelNum + 1 in Global.levels.keys():
		#	Global.levels[LevelNum + 1][1] = false
		
		var nextLevel = load(Global.levels[LevelNum]["scene"])
		Global.currentLevelNum = nextLevel
		print(get_tree().change_scene_to(nextLevel))
