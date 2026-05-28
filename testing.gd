extends Node2D
var unit_scene: PackedScene = preload("res://unit.tscn")

func _ready():
	var units = $units
	var spawn_pos = $spawns/marker1
	var unit = unit_scene.instantiate() as CharacterBody2D
	unit.position = spawn_pos.position
	units.add_child(unit)
	unit.set_allegiance(0, 0)
	unit.set_unit_type(7)
	spawn_pos = $all_spawn/unit_spawns_circle.get_children()
	
