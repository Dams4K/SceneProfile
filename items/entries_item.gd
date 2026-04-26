extends ProfileItem
class_name EntriesItem

@export var entries: Array[PropertyEntry] = [] : set = set_entries

var target: Object


func _init() -> void:
	_sync_targets()


func set_entries(p_entries: Array[PropertyEntry]) -> void:
	entries = p_entries
	_sync_targets()


func apply(preset: SceneProfileInterpretor.Presets) -> void:
	assert(target != null, "Target can't be null")
	for entry: PropertyEntry in entries:
		set_property(entry, preset)


func set_property(entry: PropertyEntry, preset: SceneProfileInterpretor.Presets) -> void:
	target.set(entry.property, entry.get_value(preset))


func _sync_targets() -> void:
	if interpretor == null:
		return
	
	for entry in entries:
		if entry == null: continue
		entry.target = target


func set_interpretor(value: SceneProfileInterpretor) -> void:
	super.set_interpretor(value)
	_sync_targets()
