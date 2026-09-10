extends Node2D
var start = null

func _process(_delta: float) -> void:
	queue_redraw()

func _draw():
	if Input.is_action_just_pressed("LMB"):
		start = get_viewport().get_mouse_position() # starting coords of the selection box.
	if Input.is_action_pressed("LMB"):
		var cur_mouse_pos = get_viewport().get_mouse_position() # current moujse position
		var rect_size = Vector2(cur_mouse_pos.x - start.x, cur_mouse_pos.y - start.y) # gets proper size of the selection box
		var sel_rect = Rect2(start.x, start.y, rect_size.x, rect_size.y) # actual selection box
		#print("LMB")
		draw_rect(sel_rect, Color(0.429, 0.611, 0.824, 0.549), true) # drawing the actual selection box
		touching_units(start, rect_size)
	if Input.is_action_just_released("LMB"):
		start = Vector2.ZERO # resets the starting coords
	#print(start, " : ", get_viewport().get_mouse_position())

func touching_units(start: Vector2, rect_size: Vector2): # the unit detection box :3
	var collision_box: CollisionShape2D =  $Area2D/CollisionShape2D
	collision_box.shape.extents = Vector2(rect_size)
	collision_box.global_position = start
