cleaning
manualCleanup
	10 timesRepeat: [ Smalltalk garbageCollect ].
	MTMetaLinksInstaller allInstances first.
	MTMetaLinksInstaller allInstances
		do: [ :each | SystemAnnouncer uniqueInstance unsubscribe: each ].
	MTMetaLinksInstaller destroyAllLinksEverywhereFor: MTElement.
	MTMetaLinksInstaller destroyAllLinksEverywhereFor: MTContainer