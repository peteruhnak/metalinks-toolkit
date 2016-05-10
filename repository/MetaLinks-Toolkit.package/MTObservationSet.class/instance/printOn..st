printing
printOn: aStream
	super printOn: aStream.
	aStream nextPutAll: '(';  cr; tab.
	aStream nextPutAll: '#change -> '.
	self change printOn: aStream.
	aStream nextPutAll: '.'; cr; tab.
	aStream nextPutAll: '#add -> '.
	self add printOn: aStream.
	aStream nextPutAll: '.'; cr; tab.
	aStream nextPutAll: '#remove -> '.
	self remove printOn: aStream.
	aStream nextPutAll: ''; cr.
	aStream nextPutAll: ')'