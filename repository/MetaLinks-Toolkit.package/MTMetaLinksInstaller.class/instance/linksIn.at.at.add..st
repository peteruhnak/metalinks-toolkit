accessing
linksIn: aStorage at: aClass at: aName add: aLink
	^ ((aStorage at: aClass ifAbsentPut: [ Dictionary new ])
		at: aName
		ifAbsentPut: [ OrderedCollection new ]) add: aLink