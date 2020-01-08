extends StaticBody2D

onready var inside:  Node2D = $Inside
onready var outside: Node2D = $Outside
onready var camera_zoom_tween: Tween = $CameraZoomTween

var zoom_in_factor = 0.5

func _ready():
	inside.visible = false

func _on_FloorArea_body_entered(body: PhysicsBody2D):
	inside.visible = true
	outside.visible = false
	zoom_camera(body, zoom_in_factor)

func _on_FloorArea_body_exited(body: PhysicsBody2D):
	inside.visible = false
	outside.visible = true
	zoom_camera(body, 1.0)

func zoom_camera(body, factor):
	var camera: Camera2D = body.get_node('Camera2D')
	camera_zoom_tween.interpolate_property(camera, "zoom", null, body.cameraZoom * factor, .5, Tween.TRANS_EXPO, Tween.EASE_OUT, 0)
	camera_zoom_tween.start()
