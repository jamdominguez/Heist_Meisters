extends "res://scripts/characters/TemplateCharacter.gd"

var motion = Vector2()

func _physics_process(delta):	
	update_movement()
	move_and_slide(motion)

# Movemente function
# clamp function limit the movement between two values, without it, the movement has not control
# lerp function helps to sense de movement more real making the stoping movement progresive
func update_movement():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		#motion.y += SPEED
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		#motion.y -= SPEED
		motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
	else:
		#motion.y = 0
		motion.y = lerp(motion.y, 0, FRICTION)

	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		#motion.x -= SPEED
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
	elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		#motion.x += SPEED
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
	else:
		#motion.x = 0
		motion.x = lerp(motion.x, 0, FRICTION)

func _input(event):
	if Input.is_action_just_pressed("torch_toggle"):
		print("torch_toggle event...")
		#$Torch.enabled = !$Torch.enabled
