extends CharacterBody2D

var selected = []
const SPEED = 1000.0
var dir
var start = null
@onready var cam = $Selector/Camera2D
@onready var collision_box: CollisionShape2D = $Selector/CollisionShape2D
@onready var selector = $Selector
@onready var itself = $"."
var alleg = "unassigned" # allegiance
var cur_zoom = Vector2(1,1)
var offset = Vector2.ZERO

func _draw():
	if Input.is_action_just_pressed("LMB"):
		start = get_global_mouse_position() # starting coords of the selection box.
	if Input.is_action_pressed("LMB"):
		var cur_mouse_pos = get_global_mouse_position() # current mouse position
		var rect_size = Vector2(cur_mouse_pos.x - start.x, cur_mouse_pos.y - start.y) # gets proper size of the selection box
		var sel_rect = Rect2(start.x - offset.x, start.y - offset.y, rect_size.x, rect_size.y) # actual selection box
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
	selected = selector.get_overlapping_areas()

func get_selected():
	var selected_out = [] # since I switched to Area2Ds for unit selection I have to first 'sanitize' the output to make sure the rest of my code (which expects CharacterBody2Ds) works.
	for i in selected:
		var switch = i.get_parent()
		selected_out.append(switch)
	return selected_out

func _process(delta: float) -> void:
	dir = Input.get_vector("Left", "Right", "Up", "Down")
	global_position += (SPEED * dir * delta)
	offset += (SPEED * dir * delta)
	if Input.is_action_just_pressed("MMB"):
		cam.zoom = Vector2(1,1)
	
	if Input.is_action_just_pressed("Scroll_Up") and not cur_zoom > Vector2(6,6):
		cur_zoom += Vector2(0.1, 0.1)
		if cur_zoom > Vector2(3,3):
			cur_zoom += Vector2(0.2, 0.2)
			if cur_zoom > Vector2(4.5,4.5):
				cur_zoom += Vector2(0.2, 0.2)
	if  Input.is_action_just_pressed("Scroll_Down") and not cur_zoom < Vector2(0.5,0.5):
		cur_zoom -= Vector2(0.1, 0.1)
		if cur_zoom > Vector2(3,3):
			cur_zoom -= Vector2(0.2, 0.2)
			if cur_zoom > Vector2(4.5,4.5):
				cur_zoom -= Vector2(0.2, 0.2)
	cam.zoom = cur_zoom

	queue_redraw()
