extends Spatial

onready var bulletScene = load("res://bullet.tscn")
onready var muzzle = get_node("Position3D")

func _physics_process(delta):
	if Input.is_action_just_pressed("выстрел"):
		var bullet = bulletScene.instance()
		get_node("../../..").add_child(bullet)
		bullet.global_transform = muzzle.global_transform
		bullet.scale = Vector3(0.2, 0.2, 0.2)

