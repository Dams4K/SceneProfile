@tool
@abstract
extends EntriesItem
class_name SingletonItem

@export_storage var singleton:
	set(v):
		singleton = v
		target = Engine.get_singleton(v)
		_sync_targets()

func _init() -> void:
	target = Engine.get_singleton(singleton)


func _sync_targets() -> void:
	target = Engine.get_singleton(singleton)
	super._sync_targets()


func set_property(entry: PropertyEntry, quality: Presets.Quality) -> void:
	var value = entry.get_value(quality)
	if value == null:
		return
	target.set_setting(entry.property, value)
