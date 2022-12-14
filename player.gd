extends KinematicBody

var speed = 7
var acceleration = 10
var gravity = 0.09
var jump = 10

var mouse_sensitivity = 0.1

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3() 

onready var head = $Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity)) 
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity)) 
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	
	direction = Vector3()
	
# warning-ignore:return_value_discarded
	move_and_slide(fall, Vector3.UP)
	
	if not is_on_floor():
		fall.y -= gravity
		
	if Input.is_action_just_pressed("прыжок") and is_on_floor():
		fall.y = jump
		
	
	if Input.is_action_pressed("вперёд"):
	
		direction -= transform.basis.z
	
	elif Input.is_action_pressed("назад"):
		
		direction += transform.basis.z
		
	if Input.is_action_pressed("влево"):
		
		direction -= transform.basis.x			
		
	elif Input.is_action_pressed("вправо"):
		
		direction += transform.basis.x
			
		
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta) 
	velocity = move_and_slide(velocity, Vector3.UP) 
