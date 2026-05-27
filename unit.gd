extends CharacterBody2D

var rng = RandomNumberGenerator.new()

# division speeds
@export var inf_spd = 1.0
@export var mnt_spd = 1.1
@export var mil_spd = 1.3
@export var strm_spd = 1.5
@export var para_spd = 1.5
@export var sf_spd = 1.6

@export var moto_spd = 2.5
@export var mech_spd = 2.2
@export var arm_spd = 3.0


var SPEED = 50.0
var SPEEDS = [inf_spd, mnt_spd, mil_spd, strm_spd, para_spd, sf_spd, moto_spd, mech_spd, arm_spd]

func _ready() -> void:
	randomize()
	var r = randi_range(0, len(SPEEDS))
	type_id(r)

func _process(delta: float) -> void:
	pass

func type_name(unit: String):
	pass

func type_id(unit: int):
	print(unit)

func move(pos: Array):
	pass
