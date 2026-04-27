@tool
extends Node
class_name SceneProfileInterpretor

@export var quality := Presets.get_quality():
	set(v):
		quality = v
		apply()

@export var items: Array[ProfileItem] = []:
	set(value):
		items = value
		_sync_interpretors()


func _ready() -> void:
	quality = Presets.get_quality() # Force
	_sync_interpretors()
	apply()



func _sync_interpretors() -> void:
	for item: ProfileItem in items:
		if item == null: continue
		item.interpretor = self


func apply() -> void:
	for item: ProfileItem in items:
		item.apply(quality)
