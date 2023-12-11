extends Node3D
class_name HealthNode

var _max_health: float
var _current_health: float

func setup(max_health: float):
	_max_health = max_health
	_current_health = max_health

func damage(damage_taken: float) -> float:
	_current_health = min(_current_health - damage_taken, _max_health)
	
	if _current_health <= 0:
		get_parent_node_3d().queue_free()
	return _current_health

func modifyMaxHealth(new_max_health) -> float:
	var difference: float = new_max_health - _max_health
	_max_health = new_max_health
	if(difference < 0):
		return damage(0)
	return damage(difference)
