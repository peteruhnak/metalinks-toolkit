running
tearDown
	super tearDown.
	installer installer uninstallAllPermanentLinksIn: MTElement.
	installer installer uninstallAllPermanentLinksIn: MTContainer