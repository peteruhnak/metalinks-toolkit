inferring
inferClass: aClass
	| observations |
	observations := MTObservationSet new.
	observations target: aClass.
	observations add: (self additionsIn: aClass).
	observations remove: (self removalsIn: aClass).
	observations change: (self instanceVariablesIn: aClass).
	^ observations