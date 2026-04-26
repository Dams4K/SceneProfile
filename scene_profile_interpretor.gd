@tool
extends Node
class_name SceneProfileInterpretor

enum Presets {
	LOW,
	MEDIUM,
	HIGH,
	ULTRA
}

@export var editor_preset := Presets.MEDIUM

@export var items: Array[ProfileItem] = []:
	set(value):
		items = value
		_sync_interpretors()


func _ready() -> void:
	_sync_interpretors()
	apply()



func _sync_interpretors() -> void:
	for item: ProfileItem in items:
		item.interpretor = self


func apply() -> void:
	var preset := SceneProfilePlugin.get_preset()
	for item: ProfileItem in items:
		item.apply(preset)
