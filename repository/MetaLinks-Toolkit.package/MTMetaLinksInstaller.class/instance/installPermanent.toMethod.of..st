installing
installPermanent: aLink toMethod: aName of: aClass
	self
		linksIn: methodLinks
		at: aClass
		at: aName
		add: aLink.
	(aClass >> aName) ast link: aLink