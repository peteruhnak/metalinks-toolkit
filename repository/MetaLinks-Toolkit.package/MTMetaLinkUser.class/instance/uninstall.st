actions
uninstall
	(target links isNotNil and: [ target links isNotEmpty ])
		ifTrue: [ target links do: #uninstall ]