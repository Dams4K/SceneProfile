extends ProfileItem
class_name EntriesItem

@export var entries: Array[PropertyEntry] = [] : set = set_entries

var target: Object


func _init() -> void:
	_sync_targets()


func set_entries(p_entries: Array[PropertyEntry]) -> void:
	entries = p_entries
	_sync_targets()


func apply(quality: Presets.Quality) -> void:
	assert(target != null, "Target can't be null")
	for entry: PropertyEntry in entries:
		set_property(entry, quality)


func set_property(entry: PropertyEntry, quality: Presets.Quality) -> void:
	target.set(entry.property, entry.get_value(quality))


func _sync_targets() -> void:
	for entry in entries:
		if entry == null: continue
		entry.target = target


func set_interpretor(value: SceneProfileInterpretor) -> void:
	super.set_interpretor(value)
	_sync_targets()
