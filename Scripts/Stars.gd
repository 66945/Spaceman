extends ParallaxLayer
tool

export var starSeed = 0
export var num = 10

export (Rect2) var starRange

onready var Star = load("res://Scenes/star.tscn")

var prevSeed = 0
var prevNum = 0

func _ready():
	generate()

func _process(_delta):
	if Engine.editor_hint and (prevSeed != starSeed or prevNum != num):
		print("generating")
		
		for child in get_children():
			child.queue_free()
		
		generate()
		
		prevSeed = starSeed
		prevNum = num

func generate():
	var rng = RandomNumberGenerator.new()
	rng.seed = starSeed
	
	for _i in range(num):
		var star = Star.instance()
		
		star.position = Vector2(rng.randi_range(starRange.position.x,\
			starRange.size.x + starRange.position.x),\
			rng.randi_range(starRange.position.y, starRange.size.y + starRange.position.y))
		add_child(star)
