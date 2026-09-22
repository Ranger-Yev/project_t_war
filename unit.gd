extends CharacterBody2D

var rng = RandomNumberGenerator.new()
# outside resources
@onready var itself = $"."
var main_scene_node
@onready var sprite = $unit_graphic
@onready var audio_p = $audio_player
@onready var select_hitbox = $select_hitbox
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
var UNITCOLORS = [[Color8(50,60,210,255), Color8(15,85,125,255), Color8(130,165,140,255), Color8(65,230,120,255), Color8(210,130,90,255)], [Color8(0,0,0,255), Color8(135.0, 18.004, 19.406, 1.0)], [Color8(200,0,200,255), Color8(185,150,255,255)]]


# internal variables not meant for human eyes
var BASESPEED = 200.0
var DIVISIONS = [inf_um, inf_mntrs, inf_mil, inf_strm, inf_para, inf_sf, inf_moto, inf_mech, armor_mbt]

var division_type = ["infantry_um"]
var allegiance = "federal"
var unit_color = Color8(0,0,0,0);
var selected = false
var audio_play = true

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

func _process(delta: float) -> void:
	var useless = delta - delta
	print(useless)
	print(main_scene_node)
	print(selected)
	print(audio_play)
	pass


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
