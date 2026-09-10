extends Node2D
var start = null

func _process(_delta: float) -> void:
	queue_redraw()

func _draw():
	if Input.is_action_just_pressed("LMB"):
		start = get_viewport().get_mouse_position()
	if Input.is_action_pressed("LMB"):
		var cur_mouse_pos = get_viewport().get_mouse_position()
		var sel_rect = Rect2(start.x, start.y, cur_mouse_pos.x - start.x, cur_mouse_pos.y - start.y)
		#print("LMB")
		draw_rect(sel_rect, Color(0.429, 0.611, 0.824, 0.549), true)
	if Input.is_action_just_released("LMB"):
		start = Vector2.ZERO
	print(start, " : ", get_viewport().get_mouse_position())
