accessing
linksIn: aStorage at: aClass at: aName
	aStorage at: aClass ifAbsent: [ ^ #() ].
	^ (aStorage at: aClass) at: aName ifAbsent: [ #() ]