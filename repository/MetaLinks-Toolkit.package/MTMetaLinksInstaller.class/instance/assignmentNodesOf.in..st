accessing
assignmentNodesOf: anAttribute in: aClass
	^ aClass assignmentNodes
		select: [ :each | 
			each variable name = anAttribute
				and: [ (ignoredSelectors includes: each methodNode method selector) not ] ]