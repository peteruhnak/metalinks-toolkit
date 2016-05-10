instance creation
target: aTarget change: aChangeSet add: anAddSet remove: aRemoveSet
	^ self new
		target: aTarget;
		change: aChangeSet;
		add: anAddSet;
		remove: aRemoveSet;
		yourself