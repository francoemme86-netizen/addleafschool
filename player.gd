extends CharacterBody3D

const WALK_SPEED = 2.5
const MOUSE_SENSITIVITY = 0.002

@onready var camera_pivot: Node3D = find_child("CameraPivot") as Node3D
@onready var camera: Camera3D = find_child("Camera3D") as Camera3D

# Cerca il nodo della luce che abbiamo appena creato
@onready var flashlight: SpotLight3D = find_child("Flashlight") as SpotLight3D
var flashlight_on: bool = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Forza la telecamera ad attivarsi
	if camera != null:
		camera.make_current()
	
	# La torcia parte spenta all'inizio del gioco
	if flashlight != null:
		flashlight.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		if camera_pivot != null:
			camera_pivot.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
			camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(-45), deg_to_rad(45))

func _process(_delta: float) -> void:
	# --- TASTO F: ACCENDI / SPEGNI TORCIA ---
	if Input.is_action_just_pressed("toggle_flashlight"):
		if flashlight != null:
			flashlight_on = !flashlight_on
			flashlight.visible = flashlight_on
			print("Torcia interruttore: ", flashlight_on)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_direction = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		input_direction -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		input_direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		input_direction -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		input_direction += transform.basis.x

	input_direction = input_direction.normalized()

	if input_direction != Vector3.ZERO:
		velocity.x = input_direction.x * WALK_SPEED
		velocity.z = input_direction.z * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		velocity.z = move_toward(velocity.z, 0, WALK_SPEED)

	move_and_slide()
