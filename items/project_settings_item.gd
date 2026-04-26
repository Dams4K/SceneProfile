@tool
extends EntriesItem
class_name ProjectSettingsItem

func _init() -> void:
	target = Engine.get_singleton("ProjectSettings")


func _sync_targets() -> void:
	target = Engine.get_singleton("ProjectSettings")
	super._sync_targets()


func set_property(entry: PropertyEntry, quality: Presets.Quality) -> void:
	var value = entry.get_value(quality)
	if value == null:
		return
	target.set_setting(entry.property, value)
