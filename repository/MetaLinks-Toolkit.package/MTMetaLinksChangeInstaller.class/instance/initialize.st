initialization
initialize
	super initialize.
	installer := MTMetaLinksInstaller new.
	changeMetaObjectBlock := [ :object :newValue | object announcer announce: (ValueChanged newValue: newValue) ].
	addMetaObjectBlock := [ :object :arguments | object announcer announce: (ValueAdded newValue: arguments first) ].
	removeMetaObjectBlock := [ :object :arguments | object announcer announce: (ValueRemoved new oldValue: arguments first) ]