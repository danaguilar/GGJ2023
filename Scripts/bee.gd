extends KinematicBody2D

signal hit_player()
signal goomba_jump()

# Public

onready var sprite = $Sprite

export var movementSpeed = 20
export var gravityPower = 10
export var leashDistance = 10
export var isMovingVerticle = false

# Private

var direction = 0
var gravity = 0
var movementAwayFromOrigin = 0
var dead = false

# Methods

func _physics_process(delta):
	# bee falls if dead
	if dead :
		gravity += gravityPower
		position.y += gravity * delta
		
		return
	
	if isMovingVerticle:
		if direction == 0:
			move_and_slide(Vector2(0,  movementSpeed), Vector2(0, -1))
			movementAwayFromOrigin += movementSpeed*delta
		else:
			move_and_slide(Vector2(0, -movementSpeed), Vector2(0, -1))
			movementAwayFromOrigin -= movementSpeed*delta
			
		if is_on_ceiling() or is_on_floor() or reached_max_distance():
			if direction == 0: direction = 1
			elif direction == 1: direction = 0
			
	else:
		if direction == 0:
			move_and_slide(Vector2( movementSpeed, 0), Vector2(0, -1))
			movementAwayFromOrigin += movementSpeed*delta
			sprite.flip_h = false
		else:
			move_and_slide(Vector2(-movementSpeed, 0), Vector2(0, -1))
			movementAwayFromOrigin -= movementSpeed*delta
			sprite.flip_h = true
			
		if is_on_wall() or reached_max_distance():
		
			if direction == 0: direction = 1
			elif direction == 1: direction = 0
	
	if(get_slide_count() == 0): return
	
	var player_hit = false
	var bee_hit = false
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Player":
			if(get_last_slide_collision().collider_shape_index == 0):
				player_hit = true
			else:
				bee_hit = true
	if bee_hit:
		hit()
		emit_signal("goomba_jump")
		return
	
	if player_hit:
		emit_signal("hit_player")
		return


func reached_max_distance():
	return movementAwayFromOrigin > leashDistance or movementAwayFromOrigin < 0
	
func hit():
	if dead : return
	sprite.stop()
	sprite.rotation_degrees = 180
	
	dead = true
	gravity = -120
