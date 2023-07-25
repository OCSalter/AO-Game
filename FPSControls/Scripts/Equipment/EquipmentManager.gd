extends Node3D

class_name EquipmentManager

@onready var equipment = $Equipment
@onready var shotgun: Equipment = $Equipment/Shotgun
@onready var list: Array[Equipment] = [shotgun]
var equiped: int = 0

func fire(camera_position: Vector3, camera_transform: Transform3D):
	list[equiped].fire(camera_position, camera_transform)
	
func alt_fire(camera_position: Vector3, camera_transform: Transform3D):
	list[equiped].alt_fire(camera_position, camera_transform)

func _process(delta):
	equipment.position.x = lerp(equipment.position.x, 0.0, delta * 5)
	equipment.position.y = lerp(equipment.position.y, 0.0, delta * 5)
	
func sway(swayAmount: Vector2):
	equipment.position.x += swayAmount.x * 0.00005
	equipment.position.y += swayAmount.y * 0.00005
