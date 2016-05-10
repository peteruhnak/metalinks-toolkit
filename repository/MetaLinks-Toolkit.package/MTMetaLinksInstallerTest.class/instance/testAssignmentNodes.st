tests
testAssignmentNodes
	self deny: (target class selectors includes: #resetName).
	self
		set: (installer assignmentNodesOf: #name in: target class)
		equals: {(target class >> #name:) ast assignmentNodes first}