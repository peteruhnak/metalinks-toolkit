accessing
target: anAstNode
	target := anAstNode isCompiledMethod
		ifTrue: [ anAstNode ast ]
		ifFalse: [ anAstNode ]