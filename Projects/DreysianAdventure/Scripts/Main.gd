extends Control


func _ready():
	get_tree().get_root().connect("size_changed", Callable(self, "set_layout"))
	set_layout()
	get_map_events()
	load_map_events()
	

func set_layout():
	Global.load_window()
	self.size = Vector2(Global.WindowX, Global.WindowY)
	
	Global.MapBorder.custom_minimum_size.x = 0
	Global.MapControls.custom_minimum_size.x = 0
	if Global.WindowY > Global.WindowX:
		Global.PhoneControls.size = Vector2(Global.WindowX, Global.WindowY * 0.1)
		Global.PhoneControls.position = Vector2(0,0)
		Global.PhoneControls.visible = true
		
		Global.MapContainer.size = Vector2(Global.WindowX, Global.WindowY * 0.4)
		Global.MapContainer.position = Vector2(0, Global.WindowY * 0.1)
		Global.MapContainer.visible = true
		
		Global.Log.size = Vector2(Global.WindowX, Global.WindowY * 0.4)
		Global.Log.position = Vector2(0, Global.WindowY * 0.1)
		Global.Log.visible = false
		
		Global.Inventory.size = Vector2(Global.WindowX, Global.WindowY * 0.4)
		Global.Inventory.position = Vector2(0, Global.WindowY * 0.1)
		Global.Inventory.visible = false
		
		Global.PartyInfo.size = Vector2(Global.WindowX, Global.WindowY * 0.4)
		Global.PartyInfo.position = Vector2(0, Global.WindowY * 0.1)
		Global.PartyInfo.visible = false
		
		Global.ActionView.size = Vector2(Global.WindowX, Global.WindowY * 0.4)
		Global.ActionView.position = Vector2(0, Global.WindowY * 0.5)
		Global.ActionView.visible = false
		
		Global.Account.size = Vector2(Global.WindowX, Global.WindowY * 0.1)
		Global.Account.position = Vector2(0, Global.WindowY * 0.9)
	else:
		Global.PhoneControls.visible = false
		
		Global.Log.size = Vector2(Global.WindowX * 0.3, Global.WindowY * 0.9)
		Global.Log.position = Vector2(0, 0)
		Global.Log.visible = true
		
		Global.Account.size = Vector2(Global.WindowX * 0.3, Global.WindowY * 0.1)
		Global.Account.position = Vector2(0, Global.WindowY - Global.Account.size.y)
		
		Global.MapContainer.size = Vector2(Global.WindowX * 0.4, Global.WindowY * 0.5)
		Global.MapContainer.position = Vector2((Global.WindowX / 2) - (Global.MapContainer.size.x / 2), 0)
		Global.MapContainer.visible = true
		
		Global.ActionView.size = Vector2(Global.WindowX * 0.4, Global.WindowY * 0.5)
		Global.ActionView.position = Vector2((Global.WindowX / 2) - (Global.ActionView.size.x / 2), Global.WindowY - Global.ActionView.size.y)
		Global.ActionView.visible = true
		
		Global.PartyInfo.size = Vector2(Global.WindowX * 0.3, Global.WindowY * 0.3)
		Global.PartyInfo.position = Vector2(Global.WindowX - Global.PartyInfo.size.x, 0)
		Global.PartyInfo.visible = true
		
		Global.Inventory.size = Vector2(Global.WindowX * 0.3, Global.WindowY * 0.7)
		Global.Inventory.position = Vector2(Global.WindowX - Global.Inventory.size.x, Global.WindowY - Global.Inventory.size.y)
		Global.Inventory.visible = true
		
	Global.LogText.size = Global.Log.size
	
	Global.MapBorder.custom_minimum_size.x = Global.MapContainer.size.x * 0.8 - 1
	Global.MapBorder.size = Vector2(Global.MapContainer.size.x * 0.8, Global.MapContainer.size.y)
	Global.ViewContainer.size = Vector2(Global.MapContainer.size.x * 0.8 - 10, Global.MapContainer.size.y - 10)
	Global.MapControls.custom_minimum_size.x = Global.MapContainer.size.x * 0.2 - 1
	Global.MapControls.size = Vector2(Global.MapContainer.size.x * 0.2, Global.MapContainer.size.y)
	Global.MapControls.position = Vector2(Global.MapContainer.size.x - Global.MapControls.size.x,0)
	Global.MapOptions.size = Global.MapControls.size
	
	Global.Items.size = Global.Inventory.size
	
	for button in Global.PhoneControls.get_children():
		button.size.x = Global.PhoneControls.size.x / Global.PhoneControls.get_child_count()
		button.size.y = Global.PhoneControls.size.y
		button.position.x = button.get_index() * button.size.x
		
	for button in Global.Account.get_children():
		button.size.x = Global.Account.size.x / Global.Account.get_child_count()
		button.size.y = Global.Account.size.y
		button.position.x = button.get_index() * button.size.x
		
		
func get_map_events():
	var file = FileAccess.open("res://Scripts/mapevents.json",FileAccess.READ)
	var text = file.get_as_text()
	
	var json = JSON.parse_string(text)
	Libraries.map_events = json

	file.close()
	

func load_map_events():
	var Map = get_node("MapContainer/MapBorder/ViewContainer/MapView/Map/MapSprite")
	for event in Libraries.map_events:
		var marker = Global.map_marker.instantiate()
		Map.add_child(marker)
		marker.position = Vector2(event.LocationX, event.LocationY)
		marker.modulate = event.Color
		

func _on_ToggleMap_pressed():
	Global.MapContainer.visible = true
	Global.Log.visible = false
	Global.Inventory.visible = false
	Global.PartyInfo.visible = false

func _on_ToggleLog_pressed():
	Global.MapContainer.visible = false
	Global.Log.visible = true
	Global.Inventory.visible = false
	Global.PartyInfo.visible = false

func _on_ToggleInventory_pressed():
	Global.MapContainer.visible = false
	Global.Log.visible = false
	Global.Inventory.visible = true
	Global.PartyInfo.visible = false

func _on_TogglePartyInfo_pressed():
	Global.MapContainer.visible = false
	Global.Log.visible = false
	Global.Inventory.visible = false
	Global.PartyInfo.visible = true

var events = {}
var PanningStart
var placing_marker
var Target
var last_zoom_drag_distance = 0
func _input(event):
	var MapMain = Global.ViewContainer.find_child("Map")
	var Cam = MapMain.find_child("Camera2D")
	var Map = MapMain.find_child("MapSprite")
	var zoom_speed = MapMain.zoom_speed
	
	if event.is_action_released("scroll_down"):
		if Util.in_box(event.position, Global.ViewContainer.get_global_position(), Global.ViewContainer.size + Global.ViewContainer.get_global_position()):
			Cam.zoom += Vector2(zoom_speed,zoom_speed)
	if event.is_action_released("scroll_up"):
		if Util.in_box(event.position, Global.ViewContainer.get_global_position(), Global.ViewContainer.size + Global.ViewContainer.get_global_position()):
			Cam.zoom -= Vector2(zoom_speed,zoom_speed)
	if event is InputEventScreenTouch:
		
		if event.pressed and Util.in_box(event.position, Global.ViewContainer.get_global_position(), Global.ViewContainer.size + Global.ViewContainer.get_global_position()):
			
			events[event.index] = event
			PanningStart = Cam.position
			
			if MapMain.map_option == 1:
				placing_marker = true
		elif !event.pressed:
			events.erase(event.index)
			if(placing_marker):
				if Cam.position == PanningStart:
					if Map.has_node("Target"):
						Target.position = Map.get_local_mouse_position()
					else:
						Map.add_child(Target)
						Target.position = Map.get_local_mouse_position()
						Target.modulate = "#FFFF00"
				placing_marker = false
			PanningStart = null
	if event is InputEventScreenDrag:
		if PanningStart != Cam.position:
			placing_marker = false
		events[event.index] = event
		if events.size() == 1:
			if PanningStart != null:
				Cam.position -= event.relative.rotated(rotation) / Cam.zoom
		elif events.size() == 2:
			placing_marker = false
			var zoom_drag_distance = events[0].position.distance_to(events[1].position)
			var distance_change = abs(zoom_drag_distance - last_zoom_drag_distance)
			if abs(distance_change) > MapMain.zoom_sensitivity:
				var new_zoom = (zoom_speed * distance_change) if zoom_drag_distance < last_zoom_drag_distance else  -(zoom_speed * distance_change)
				Cam.zoom += Vector2(new_zoom, new_zoom).normalized() * 0.1
				last_zoom_drag_distance = zoom_drag_distance
	MapMain.checkCam()
