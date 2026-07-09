extends Node2D
var unit_scene: PackedScene = preload("res://unit.tscn")

func _ready(): # sets up all the units
	var units = $units

	var unit = unit_scene.instantiate() as CharacterBody2D
	units.add_child(unit)
	unit.set_allegiance(0, 0)
	unit.set_unit_type(7)
	
	var spawn_pos = $spawns.get_children()
	unit.global_position = spawn_pos[0].global_position
	units.add_child(unit)
	unit.set_allegiance(0, 0)
	unit.set_unit_type(7)
	
	unit.global_position = spawn_pos[1].global_position
	units.add_child(unit)
	unit.set_allegiance(0, 0)
	unit.set_unit_type(7)
	unit.global_position = spawn_pos[1].global_position

	spawn_pos = $spawns.get_children()
	var fed = $spawns/federal
	var circle = $spawns/golden_circle

	
	for i in spawn_pos:
		for y in i.get_children():
			unit = unit_scene.instantiate() as CharacterBody2D
			units.add_child(unit)
			if i == fed:
				configure_unit(unit, 0, 0, 7, y.global_position)
				#print("federal")
			if i == circle:
				if y == $spawns/golden_circle/marker1:
					configure_unit(unit, 1, 0, 2, y.global_position)
				else:
					configure_unit(unit, 1, 0, 3, y.global_position)
				#print("circle")

#_________________________________________________________
# Federal, Teklasiana, Commonwealth, Cascadia, Consumerist
# 0, 0   | 0, 1      | 0, 2        | 0, 3    | 0, 4

# Golden Circle, Tinkleologist, Unions
# 1, 0         | 1, 1         | 1, 2

# Tinkle
# 3, any value

# inf_um, inf_mntrs, inf_mil, inf_strm, inf_para, inf_sf, inf_moto, inf_mech, armor_mbt
# 0       1          2        3         4         5       6         7         8

# unit, faction, state, unit type
func configure_unit(u: CharacterBody2D, f: int, s: int, ut: int, pos) -> void:
	if f > 2 or f < 0:
		f == 0
