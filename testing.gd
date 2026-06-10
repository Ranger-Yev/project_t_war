extends Node2D
var unit_scene: PackedScene = preload("res://unit.tscn")

func _ready():
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
	
