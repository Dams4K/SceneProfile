extends ProfileItem
class_name EntriesItem

@export var entries: Array[Entry] = [] : set = set_entries

var target: Object


func _init() -> void:
	_sync_targets()


func set_entries(p_entries: Array[Entry]) -> void:
	entries = p_entries
	_sync_targets()


func apply(quality: Presets.Quality) -> void:
	assert(target != null, "Target can't be null")
	for entry: Entry in entries:
		entry.target = target
		entry.apply(quality)


func _sync_targets() -> void:
	for entry in entries:
		if entry == null: continue
		entry.target = target


func set_interpretor(value: SceneProfileInterpretor) -> void:
	super.set_interpretor(value)
	_sync_targets()
