extends Node

@onready var Screen = get_node("/root/Screen")
@onready var MapContainer = get_node("/root/Screen/MapContainer")
@onready var MapBorder = get_node("/root/Screen/MapContainer/MapBorder")
@onready var ViewContainer = get_node("/root/Screen/MapContainer/MapBorder/ViewContainer")
@onready var MapView = get_node("/root/Screen/MapContainer/MapBorder/ViewContainer/MapView")
#onready var Map = get_node("/root/Screen/MapContainer/MapBorder/ViewContainer/Mapview/Map") #NOT FOUND
@onready var MapControls = get_node("/root/Screen/MapContainer/MapControls")
@onready var MapOptions = get_node("/root/Screen/MapContainer/MapControls/MapOptions")
@onready var Log = get_node("/root/Screen/Log")
@onready var LogText = get_node("/root/Screen/Log/LogText")
@onready var ActionView = get_node("/root/Screen/ActionView")
@onready var Inventory = get_node("/root/Screen/Inventory")
@onready var Items = get_node("/root/Screen/Inventory/Items")
@onready var Account = get_node("/root/Screen/Account")
@onready var Profile = get_node("/root/Screen/Account/Profile")
@onready var Friends = get_node("/root/Screen/Account/Friends")
@onready var Settings = get_node("/root/Screen/Account/Settings")
@onready var PartyInfo = get_node("/root/Screen/PartyInfo")
@onready var PhoneControls = get_node("/root/Screen/PhoneControls")
@onready var ToggleMap = get_node("/root/Screen/PhoneControls/ToggleMap")
@onready var ToggleLog = get_node("/root/Screen/PhoneControls/ToggleLog")
@onready var ToggleInventory = get_node("/root/Screen/PhoneControls/ToggleInventory")
@onready var TogglePartyInfo = get_node("/root/Screen/PhoneControls/TogglePartyInfo")

var WindowX
var WindowY
var ScreenSize

@onready var map_marker = preload("res://Res/MapMarker.tscn")

func load_window():
	WindowX = get_viewport().size.x
	WindowY = get_viewport().size.y
	ScreenSize = DisplayServer.screen_get_size().x * DisplayServer.screen_get_size().y
	# Computer over 1000000, tablet about 450000, phone under 300000
	
