installing
installPermanent: aLink toAttribute: aName of: aClass
	self
		linksIn: attributeLinks
		at: aClass
		at: aName
		add: aLink.
	(self assignmentNodesOf: aName in: aClass) do: [ :each | each link: aLink ]