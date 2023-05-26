extends Node2D

@onready var Cam = find_child("Camera2D")
@onready var Map = find_child("MapSprite")
var Test
@export var zoom_speed = 0.1
@export var zoom_sensitivity = 1
@export var zoom_max = Vector2(2.5,2.5)
var map_option
var Target

func _ready():
	Test = get_node("/root/Screen/Log/LogText")
	Cam.limit_left = Map.get_rect().position.x
	Cam.limit_right = Map.get_rect().end.x
	Cam.limit_top = Map.get_rect().position.y
	Cam.limit_bottom = Map.get_rect().end.y
	Target = Global.map_marker.instantiate()
	Target.set_name("Target")

func checkCam():
	#Using the clamp function doesn't work for some reason
	#The min part is fine, but lets it go beyond max
	if Cam.zoom > zoom_max:
		Cam.zoom = zoom_max
	if Cam.zoom < Vector2(0.1,0.1):
		Cam.zoom = Vector2(0.1,0.1)
	
	clamp(Cam.position.x,Cam.limit_left, Cam.limit_right)
	clamp(Cam.position.y,Cam.limit_top, Cam.limit_bottom)
	for i in Map.get_child_count():
		Map.get_child(i).scale = Cam.zoom


func _on_MapOptions_item_selected(index):
	map_option = index
