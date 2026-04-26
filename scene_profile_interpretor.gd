@tool
extends Node
class_name SceneProfileInterpretor

@export var editor_preset := Presets.Quality.MEDIUM

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
	var quality := Presets.get_quality()
	for item: ProfileItem in items:
		item.apply(quality)
