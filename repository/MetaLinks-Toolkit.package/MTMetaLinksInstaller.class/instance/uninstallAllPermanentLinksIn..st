uninstalling
uninstallAllPermanentLinksIn: aClass
	attributeLinks
		at: aClass
		ifPresent: [ :dicts | 
			dicts valuesDo: [ :col | col do: #uninstall ].
			dicts removeAll.
			attributeLinks removeKey: aClass ].
	methodLinks
		at: aClass
		ifPresent: [ :dicts | 
			dicts valuesDo: [ :col | col do: #uninstall ].
			dicts removeAll.
			methodLinks removeKey: aClass ].
	self uninstallAllLinksIn: aClass