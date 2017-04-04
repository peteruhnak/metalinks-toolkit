accessing
target: anAstNode
	target := anAstNode isCompiledMethod | (anAstNode isKindOf: ReflectiveMethod)
		ifTrue: [ anAstNode ast ]
		ifFalse: [ anAstNode ]