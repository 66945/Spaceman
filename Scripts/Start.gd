extends Node2D

func _ready():
	$AnimationPlayer.play("Move")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Move":
		$rocket/Flame.emitting = true
		$AnimationPlayer.play("Rocket")
	elif anim_name == "Rocket":
		$rocket/Flame.emitting = false
