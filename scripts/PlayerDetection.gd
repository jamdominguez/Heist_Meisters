extends "res://scripts/characters/TemplateCharacter.gd"

const FOV_TOLERANCE = 20
const MAX_DETECTION_RANGE = 640

const RED = Color(1,0.25,0.25)
const WHITE = Color (1,1,1)

# Player is typed with capital letter bacuse if the node reference
var Player

func _ready():
	Player = get_node("/root").find_node("Player", true, false)

func _process(delta):
	if is_Player_detected():
		$Torch.color = RED
	else:
		$Torch.color = WHITE
		
func is_Player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()
	
	#angle_to works with radiands, the FOV_TOLERANCE must be translate with the function deg2rad()
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false

func is_Player_in_LOS():
	var space = get_world_2d().direct_space_state
	#ray into this position and Player positon
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position,[self], collision_mask)	
	# No obstacle
	if not LOS_obstacle:
		return false
	else: 
		var collider_with_Player = LOS_obstacle.collider == Player
		var distance_to_player = Player.global_position.distance_to(global_position)
		var Player_in_range = distance_to_player < MAX_DETECTION_RANGE
		
		# if the obstacle is the player and the distancie with it is less than MAX_DETECTION_RANGE
		if collider_with_Player and Player_in_range:
			return true
		else:
			return false


func is_Player_detected():
	return is_Player_in_FOV() and is_Player_in_LOS()
