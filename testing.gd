extends Node2D
var unit_scene: PackedScene = preload("res://unit.tscn") # unit template
@onready var selector = $Selector
var pa = "unassigned" # player allegiance
var selected = []

func _process(_delta :float) -> void:
	selected = selector.get_selected()
	if Input.is_action_just_pressed("RMB") and selected != []:
		for i in selected:
			if i.get_parent().name == "federal-0":
				i.move(i.global_position, get_global_mouse_position(), true)
				#print("Destination >>> ", get_viewport().get_mouse_position() + offset, "\nCurrent Position >>> ", i.global_position, "\n")

func _ready():
	pa = "federal"
	var units = $units.get_children() # path to where all units are stored
	
	var spawn_pos = $spawns.get_children() # all spawns
	
	for i in spawn_pos:
		var spawn_unit_types = i.get_children() 
		for z in spawn_unit_types:
			#print(z)
			for y in z.get_children():
				#print(y.global_position)
				if z.name != "template_nation_spawns":
					var unit = unit_scene.instantiate() as CharacterBody2D
					var unit_type = 0
					match z.name:
						"inf_mntrs":
							unit_type = 1
						"inf_mil":
							unit_type = 2
						"inf_strm":
							unit_type = 3
						"inf_para":
							unit_type = 4
						"inf_sf":
							unit_type = 5
						"inf_moto":
							unit_type = 6
						"inf_mech":
							unit_type = 7
						"armor_mbt":
							unit_type = 8
					if i.name == "federal": # fed spawns
						units[0].add_child(unit)
						configure_unit(unit, 0, 0, unit_type, y.global_position) # union alligned, federal, unit_type
						#print("federal")
					if i.name == "teklas": # fed spawns
						units[1].add_child(unit)
						configure_unit(unit, 0, 1, unit_type, y.global_position) # union alligned, federal, unit_type
						#print("teklas")
					if i.name == "commonwealth": # fed spawns
						units[2].add_child(unit)
						configure_unit(unit, 0, 2, unit_type, y.global_position) # union alligned, federal, unit_type
						#print("commonwealth")
					if i.name == "cascadia": # fed spawns
						units[3].add_child(unit)
						configure_unit(unit, 0, 3, unit_type, y.global_position) # union alligned, federal, unit_type
						#print("cascadia")
					if i.name == "consumerist": # fed spawns
						units[4].add_child(unit)
						configure_unit(unit, 0, 4, unit_type, y.global_position) # union alligned, federal, unit_type
						#print("consumerist")
					if i.name == "golden_circle": # gc spawns
						units[5].add_child(unit)
						configure_unit(unit, 1, 0, unit_type, y.global_position) # seccession alligned, gc, unit_type
						#print("circle")
					if i.name == "unions": # gc spawns
						units[6].add_child(unit)
						configure_unit(unit, 1, 1, unit_type, y.global_position) # seccession alligned, gc, unit_type
						#print("unions")
					if i.name == "tinkle": # gc spawns
						units[7].add_child(unit)
						configure_unit(unit, 2, 0, unit_type, y.global_position) # seccession alligned, gc, unit_type
						#print("tinkle")
					if i.name == "tinkle-o": # tinkleologist spawns
						units[8].add_child(unit)
						configure_unit(unit, 2, 1, unit_type, y.global_position) # seccession alligned, gc, unit_type
						#print("tinkleologist")

#_________________________________________________________
# Federal, Teklasiana, Commonwealth, Cascadia, Consumerist
# 0, 0   | 0, 1      | 0, 2        | 0, 3    | 0, 4

# Golden Circle, Unions
# 1, 0         | 1, 1 

# Tinkle, Tinkleologist
# 2, 0  | 2, 1 

# inf_um, inf_mntrs, inf_mil, inf_strm, inf_para, inf_sf, inf_moto, inf_mech, armor_mbt
# 0       1          2        3         4         5       6         7         8

# unit, faction, state, unit type, position
func configure_unit(u: CharacterBody2D, f: int, s: int, ut: int, pos) -> void:
	if f > 2 or f <= 0: # If outside the parameters set to default US aligned
		f = 0
		if s > 4 or 0 > s: # If outside the parameters set to default US Fed Gov
			s = 0
	if f != 0 and (s > 1 or 0 > 0):
		s = 0 # If outside the parameters set to default Tinkle or GC
	u.set_allegiance(f, s)
	u.global_position = pos
	u.set_unit_type(ut)

func is_selected(u: CharacterBody2D):
	if u in selected:
		return true
	return false
