extends Node3D

class_name EquipmentManager

@onready var equipment = $Equipment
@onready var shotgun: Equipment = $Equipment/Shotgun
@onready var hml_burst: HML_Burst = $Equipment/HML_Burst
@onready var list: Array[Equipment] = [hml_burst]
var equiped: int = 0

func setup(_s: PlayerBody):
	hml_burst.player_reference = _s

func fire(_s: PlayerBody):
	list[equiped].fire(_s)
	
func alt_fire(_s: PlayerBody):
	list[equiped].alt_fire(_s)

func _process(delta):
	equipment.position.x = lerp(equipment.position.x, 0.0, delta * 5)
	equipment.position.y = lerp(equipment.position.y, 0.0, delta * 5)
	
func sway(swayAmount: Vector2):
	equipment.position.x += swayAmount.x * 0.00005
	equipment.position.y += swayAmount.y * 0.00005
