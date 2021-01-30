extends "res://scripts/characters/TemplateCharacter.gd"

const FOV_TOLERANCE = 20
const RED = Color(1,0.25,0.25)
const WHITE = Color (1,1,1)

# Player is typed with capital letter bacuse if the node reference
var Player

func _ready():
	Player = get_node("/root").find_node("Player", true, false)

func _process(delta):
	if player_in_FOV():
		$Torch.color = RED
	else:
		$Torch.color = WHITE
		
func player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()
	
	#angle_to works with radiands, the FOV_TOLERANCE must be translate with the function deg2rad()
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false