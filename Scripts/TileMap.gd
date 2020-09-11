tool
extends TileMap

func _ready():
	if not Engine.editor_hint:
		set_script(null)

func _draw():
	var width = get_used_rect().size.x + get_used_rect().position.x
	var height = get_used_rect().size.y + get_used_rect().position.y
	
	for x in int(width / 16) + 1:
		for y in int(height / 9.375) + 1:
			draw_rect(Rect2(x * 1024, y * 600, 1024, 600), Color.red, false, 4.0, true)
