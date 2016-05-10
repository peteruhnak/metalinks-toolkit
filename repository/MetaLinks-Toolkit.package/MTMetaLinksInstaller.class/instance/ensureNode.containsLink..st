linking
ensureNode: aNode containsLink: aMetaLink
	(aNode links isNil or: [ (aNode links includes: aMetaLink) not ])
		ifTrue: [ aNode link: aMetaLink ]