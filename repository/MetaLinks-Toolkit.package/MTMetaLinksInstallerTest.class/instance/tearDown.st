running
tearDown
	super tearDown.
	installer uninstallAllPermanentLinksIn: MTElement.
	(MTElement selectors includes: #resetName)
		ifTrue: [ MTElement removeSelector: #resetName ]