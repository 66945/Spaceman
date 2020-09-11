extends StaticBody2D
tool

export var num = 1
var prevNum = num

onready var Spike = load("res://Scenes/Spike.tscn")

func _ready():
	#$CollisionShape2D.shape.set_extents(Vector2(160, 24))
	
	generate()

func _process(_delta):
	if Engine.editor_hint and prevNum != num:
		print("generating")
		
		for child in $SpikeVisual.get_children():
			child.queue_free()
		
		generate()
		
		prevNum = num

func generate():
	for i in range(num):
		var newSpike = Spike.instance()
		newSpike.position.x = i * 64
		add_child(newSpike)
	
	#if Engine.editor_hint:
	#$CollisionShape2D.shape.set_extents(Vector2((num * 64) / 2, 24))
	#else:
	#	$CollisionShape2D.set_deferred("shape.extents.x", (num * 64) / 2)
	#$CollisionShape2D.position.x = (num * 64) / 2 - 32
