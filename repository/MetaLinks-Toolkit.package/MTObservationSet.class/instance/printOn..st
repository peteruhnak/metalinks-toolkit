printing
printOn: aStream
	super printOn: aStream.
	aStream nextPutAll: '{'.
	aStream nextPutAll: '#change -> '.
	self change printOn: aStream.
	aStream nextPutAll: '. #add -> '.
	self add printOn: aStream.
	aStream nextPutAll: '. #remove -> '.
	self remove printOn: aStream.
	aStream nextPutAll: '}'