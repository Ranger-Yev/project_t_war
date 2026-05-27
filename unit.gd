extends CharacterBody2D

var rng = RandomNumberGenerator.new()
# outside resources
@onready var sprite = $unit_graphic

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
var STATES = [ ["federal", "teklasiana", "commonwealth", "cascadia", "cspc"] , ["circle", "mormon", "unions"] , "tinkle"]
var UNITCOLORS = [[Color8(50,60,210,255), Color8(15,85,125,255), Color8(130,165,140,255), Color8(65,230,120,255), Color8(210,130,90,255)], [Color8(0,0,0,255), Color8(185,150,255,255), Color8(135.0, 18.004, 19.406, 1.0)], Color8(200,0,200,255)]


# internal variables not meant for human eyes
var dest = Vector2.ZERO
var in_pos = true

var BASESPEED = 200.0
var DIVISIONS = [inf_um, inf_mntrs, inf_mil, inf_strm, inf_para, inf_sf, inf_moto, inf_mech, armor_mbt]
var division_type = []
var allegiance = "federal"
var unit_color = Color8(0,0,0,0);

func _ready() -> void:
	randomize()
	randomize()
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
	if in_pos:
		in_pos = false
		randomize()
		var x = rng.randi_range(-100, 100); var y = rng.randi_range(-100, 100)
		
		dest = Vector2(x, y)
		dest = Vector2(360.0, 286.0)
	else:
		move(dest, delta)
		#print(position)
		#print(dest)
		if position == dest:
			#print("Unit is on site! <<<<")
			in_pos = true
			
	move_and_slide()

func move(pos: Vector2, delta: float):
	#print("Division is Oscar Mike.")
	var speed_modifier = division_type[1]
	var dir = Vector2((1.0 if pos.x > 0 else -1.0), (1.0 if pos.y > 0 else -1.0))
	velocity = Vector2(((BASESPEED * speed_modifier) * dir.x) * delta, ((BASESPEED * speed_modifier) * dir.y) * delta)

func select_graphic(unit_type: String, color: Color):
	var texture = load("res://assets/unit_art/" + unit_type + ".png") as CompressedTexture2D
	sprite.set_texture(texture)
	sprite.modulate = color


func print_arr(arr):
	print("{")
	for i in arr:
		print(i)
	print("}")
