extends SubViewportContainer

@onready var MapView = find_child("MapView")
@onready var Map = find_child("Map")
@onready var MapOptions = find_child("MapOptions")
var MapControl = false
var MapPan = false
var MapPanStart
var MapPanOffset


func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if MapControl:
		if Input.is_action_just_released("scroll_up"):
			MapView.size -= Vector2(5,5)
		if Input.is_action_just_released("scroll_down"):
			MapView.size += Vector2(5,5)
		if Input.is_action_just_pressed("wheel_down"):
			MapPan = true
			MapPanStart = Map.find_child("Camera2D").position
			MapPanOffset = get_local_mouse_position()
		if Input.is_action_just_released("wheel_down"):
			MapPan = false
		if MapPan:
			Map.offset = MapPanStart + get_local_mouse_position() - MapPanOffset
			pass
			
	pass

func MapControls():
	
		pass


func _on_MapContainer_mouse_entered():
	MapControl = true
	pass # Replace with function body.


func _on_MapContainer_mouse_exited():
	MapControl = false
	MapPan = false
	pass # Replace with function body.
