extends CharacterBody2D

var SPEED = 1000.0
var dirx
var diry
var start = null
@onready var collision_box: CollisionShape2D = $Selector/CollisionShape2D
@onready var selector = $Selector
@onready var sel_move = $"."

func _draw():
	if Input.is_action_just_pressed("LMB"):
		start = get_viewport().get_mouse_position() # starting coords of the selection box.
	if Input.is_action_pressed("LMB"):
		var cur_mouse_pos = get_viewport().get_mouse_position() # current moujse position
		var rect_size = Vector2(cur_mouse_pos.x - start.x, cur_mouse_pos.y - start.y) # gets proper size of the selection box
		var sel_rect = Rect2(start.x, start.y, rect_size.x, rect_size.y) # actual selection box
		#print("LMB")
		draw_rect(sel_rect, Color(0.429, 0.611, 0.824, 0.549), true) # drawing the actual selection box
		
		touching_units(start, rect_size) # detection box
	if Input.is_action_just_released("LMB"):
		start = Vector2.ZERO # resets the starting coords
		collision_box.shape.set_size(Vector2.ZERO) # resets the collision box for good luck :3
	#print(start, " : ", get_viewport().get_mouse_position())

func touching_units(local_start: Vector2, rect_size: Vector2): # the unit detection box :3
	local_start = Vector2(local_start.x + (rect_size.x / 2), local_start.y + (rect_size.y / 2))
	
	collision_box.shape.set_size(abs(Vector2(rect_size)))
	collision_box.global_position = local_start
	
	local_start.x += SPEED * dirx
	local_start.y += SPEED * diry

func _process(delta: float) -> void:
	dirx = Input.get_axis("Left", "Right")
	diry = Input.get_axis("Up", "Down")
	sel_move.global_position.x += dirx * SPEED * delta; sel_move.global_position.y += diry * SPEED * delta
	

	queue_redraw()
