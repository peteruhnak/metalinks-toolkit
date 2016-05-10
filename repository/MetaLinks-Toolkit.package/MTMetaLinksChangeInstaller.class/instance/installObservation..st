installing
installObservation: anObservation
	anObservation change
		do: [ :each | self installChangeObserverFor: each to: anObservation target ].
	anObservation add
		do: [ :each | self installAddObserverFor: each to: anObservation target ].
	anObservation remove
		do: [ :each | self installRemoveObserverFor: each to: anObservation target ]