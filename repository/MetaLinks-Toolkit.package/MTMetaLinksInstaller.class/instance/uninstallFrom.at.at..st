uninstalling
uninstallFrom: aStorage at: aName at: aClass
	aStorage
		at: aClass
		ifPresent: [ :dict | 
			dict
				at: aName
				ifPresent: [ :links | 
					links do: #uninstall.
					dict removeKey: aName ].
			dict ifEmpty: [ aStorage removeKey: aClass ] ]