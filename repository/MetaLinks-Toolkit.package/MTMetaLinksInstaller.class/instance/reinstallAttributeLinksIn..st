reinstalling
reinstallAttributeLinksIn: aMethod
	(ignoredSelectors includes: aMethod selector)
		ifTrue: [ ^ self ].
	aMethod assignmentNodes
		ifNotNil: [ :nodes | 
			nodes
				do: [ :assignment | 
					(self attributeLinksAt: aMethod methodClass at: assignment variable name)
						do: [ :link | self ensureNode: assignment containsLink: link ] ] ]