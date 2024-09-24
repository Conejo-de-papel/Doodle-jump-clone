extends KinematicBody2D

const GRAVITY := 10
var jump_force := 400
var velocity := Vector2.ZERO
var speed := 100

func _physics_process(delta: float) -> void:
	move(delta)		
	
func move(delta):
	velocity.y += GRAVITY 
	var collison = move_and_collide(velocity*delta)
	
	if collison:
		velocity.y = -jump_force
