extends CharacterBody2D

var SPEED = 5000.0

func _process(delta: float) -> void:
	var dirx := Input.get_axis("Left", "Right")
	var diry := Input.get_axis("Up", "Down")
	velocity.x = dirx * SPEED * delta
	velocity.y = diry * SPEED * delta
	move_and_slide()
