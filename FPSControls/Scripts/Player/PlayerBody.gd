extends CharacterBody3D

const GRAVITY = -24.8
const JUMP_SPEED: int = 9
const MAX_SPEED: int = 12
const ACCELERATION: int = 16
const DEACCELERATION: int = 16

@onready var camera = $OrientationManager/PlayerCamera
@onready var orientation = $OrientationManager
@onready var view_model_camera = $OrientationManager/PlayerCamera/EquipmentViewportContainer/EquipmentViewport/EquipmentManager
@onready var sub_viewport = $OrientationManager/PlayerCamera/EquipmentViewportContainer/EquipmentViewport
@onready var equipment_manager:EquipmentManager = $OrientationManager/PlayerCamera/EquipmentViewportContainer/EquipmentViewport/EquipmentManager


var direction: Vector3 = Vector3()

var MOUSE_SENSITIVITY: float = 0.05

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	sub_viewport.size = DisplayServer.window_get_size()

func _physics_process(delta):
	viewport_update()
	process_input()
	process_movment(delta)

func viewport_update():
	view_model_camera.global_transform = camera.global_transform

func process_input():
	direction = Vector3()
	var camera_xform = camera.get_camera_transform()
	var strafe_vector = Input.get_vector("left", "right", "up", "down").normalized()
	direction += camera_xform.basis.z * strafe_vector.y
	direction += camera_xform.basis.x * strafe_vector.x
	
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_SPEED
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("fire"):
		equipment_manager.fire(camera.global_position, camera.global_transform)
	if Input.is_action_just_pressed("altfire"):
		equipment_manager.alt_fire(camera.global_position, camera.global_transform)
	
func process_movment(delta):
	direction.y = 0
	direction = direction.normalized()
	velocity.y += delta * GRAVITY
	var horizontal_velocity = velocity
	horizontal_velocity.y = 0
	var acceleration = ACCELERATION if direction.dot(horizontal_velocity) > 0 else DEACCELERATION

	horizontal_velocity = horizontal_velocity.lerp(direction * MAX_SPEED, acceleration * delta)
	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z
	
	move_and_slide()

	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		orientation.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		view_model_camera.sway(Vector2(event.relative.x, event.relative.y))
		var camera_rot = orientation.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		orientation.rotation_degrees = camera_rot
		
