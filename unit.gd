extends CharacterBody2D

var rng = RandomNumberGenerator.new()
# outside resources
@onready var itself = $"."
var main_scene_node
@onready var sprite = $unit_graphic
@onready var audio_p = $audio_player
@onready var votimer = $votimer

# division attributes, list goes as follows, [String name, float speed, ]
@export var inf_um = ["infantry_um", 1.0]
@export var inf_mntrs = ["infantry_mntrs", 1.1]
@export var inf_mil = ["infantry_militia", 1.3]
@export var inf_strm = ["infantry_storm", 1.5]
@export var inf_para = ["infantry_paratroops", 1.5]
@export var inf_sf = ["infantry_sf", 1.6]
@export var inf_moto = ["infantry_moto", 2.5]
@export var inf_mech = ["infantry_mech", 2.2]
@export var armor_mbt = ["tank_division", 3.0]

# complete list of states and corresponding unit color
var STATES = [ ["federal", "teklasiana", "commonwealth", "cascadia", "cspc"] , ["circle", "unions"] , ["tinkle","tinkleologist"]]
var UNITCOLORS = [[Color.from_rgba8(75, 96, 254, 255), Color.from_rgba8(20, 156, 214, 255), Color.from_rgba8(62, 196, 178, 255), Color.from_rgba8(65,230,120,255), Color.from_rgba8(234, 110, 62, 255)], [Color.from_rgba8(0,0,0,255), Color.from_rgba8(255, 70, 94, 255)], [Color.from_rgba8(200,0,200,255), Color.from_rgba8(185,150,255,255)]]


# internal variables not meant for human eyes
var BASESPEED = 10.0
var DIVISIONS = [inf_um, inf_mntrs, inf_mil, inf_strm, inf_para, inf_sf, inf_moto, inf_mech, armor_mbt]

var division_type
var allegiance = "federal"
var unit_color = Color.from_rgba8(0,0,0,0);
var selected = false
var audio_play = true
var cur_pos = null
var destination = null

func _ready() -> void:
	if itself.get_parent().name != "root":
		#print(itself.get_parent())
		main_scene_node = itself.get_parent().get_parent().get_parent()
		#print(main_scene_node)
	#randomize()
	division_type = DIVISIONS.pick_random()
	var luck = rng.randi_range(0, 2)
	allegiance = STATES[luck]
	unit_color = UNITCOLORS[luck]
	if typeof(allegiance) == TYPE_ARRAY:
		luck = rng.randi_range(0,len(allegiance) - 1)
		allegiance = allegiance[luck]
		unit_color = unit_color[luck]
	
	select_graphic(division_type[0], unit_color)

func _physics_process(_delta: float) -> void:
	cur_pos = itself.global_position
	if cur_pos != destination and destination != null:
		move(cur_pos, destination, true)
		if sqrt(pow((destination.x - cur_pos.x), 2) + pow((destination.y - cur_pos.y), 2)) < 1: # teleports the unit and stops moving it if the unit is close enough to the destination
			itself.global_position = destination
			destination = null
	else:
		itself.velocity = Vector2.ZERO

	move_and_slide()

func move(cupos: Vector2, dest: Vector2, sel: bool) -> void: # current position and destination
	cur_pos = cupos
	destination = dest
	selected = sel
	#print(cupos, " ", dest)
	#print("moving")
	var dir = cupos - dest
	#print(dir)
	if dir.x < 0: dir.x = 1
	else: dir.x = -1
	if dir.y < 0: dir.y = 1
	else: dir.y = -1
	#print(dir)
	itself.velocity.x = dir.x * BASESPEED * division_type[1] 
	itself.velocity.y = dir.y * BASESPEED * division_type[1]   
	#print(itself.velocity)
	
func select_graphic(unit_type: String, color: Color):
	var texture = load("res://assets/unit_art/" + unit_type + ".png") as CompressedTexture2D
	sprite.set_texture(texture)
	sprite.modulate = color

func print_arr(arr):
	print("{")
	for i in arr:
		print(i)
	print("}")

# pick one of three factions, 0 = US alligned, 1 = secession alligned, 2 = TINKLE
#_________________________________________________________
# Federal, Teklasiana, Commonwealth, Cascadia, Consumerist
# 0, 0   | 0, 1      | 0, 2        | 0, 3    | 0, 4
# Golden Circle, Unions
# 1, 0         | 1, 1
# Tinkle, Tinkleologist
# 2, 0  | 2, 1 

func set_allegiance(faction_i, state_i):
	allegiance = STATES[faction_i][state_i]
	unit_color = UNITCOLORS[faction_i][state_i]
	select_graphic(division_type[0], unit_color)

# pick a division type
# inf_um, inf_mntrs, inf_mil, inf_strm, inf_para, inf_sf, inf_moto, inf_mech, armor_mbt
# 0       1          2        3         4         5       6         7         8

func set_unit_type(div_type_i):
	division_type = DIVISIONS[div_type_i]
	select_graphic(division_type[0], unit_color)

func _on_votimer_timeout() -> void:
	audio_play = true

func set_selected(sel: bool):
	selected = sel
