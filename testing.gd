extends Node2D
var unit_scene: PackedScene = preload("res://unit.tscn") # unit template

func _ready():
	var units = $units # path to where all units are stored

	var spawn_pos = $spawns.get_children() # all spawns
	var fed = $spawns/federal # federal spawns
	var circle = $spawns/golden_circle # gc spawns

	
	for i in spawn_pos:
		for y in i.get_children():
			#print(y.global_position)
			var unit = unit_scene.instantiate() as CharacterBody2D
			units.add_child(unit)
			
			# TO DO -> Units should be decided based on index which is compared to a file which then tells you the
			
			if i == fed: # fed spawns
				configure_unit(unit, 0, 0, 7, y.global_position) # union alligned, federal, mech
				#print("federal")
			if i == circle: # gc spawns
				if y == $spawns/golden_circle/marker1:
					configure_unit(unit, 1, 0, 2, y.global_position) # seccession alligned, gc, militia
				else:
					configure_unit(unit, 1, 0, 3, y.global_position) # seccession alligned, gc, stormtroops
				#print("circle")

#_________________________________________________________
# Federal, Teklasiana, Commonwealth, Cascadia, Consumerist
# 0, 0   | 0, 1      | 0, 2        | 0, 3    | 0, 4

# Golden Circle, Unions
# 1, 0         | 1, 1 

# Golden Circle, Tinkleologist, Unions
# 1, 0         | 1, 1         | 1, 2

# Tinkle, Tinkleologist
# 2, 0  | 2, 1 

# inf_um, inf_mntrs, inf_mil, inf_strm, inf_para, inf_sf, inf_moto, inf_mech, armor_mbt
# 0       1          2        3         4         5       6         7         8

# unit, faction, state, unit type
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
