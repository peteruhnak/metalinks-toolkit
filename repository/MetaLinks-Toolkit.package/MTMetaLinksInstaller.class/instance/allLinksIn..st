accessing
allLinksIn: aClass
	^ (aClass methods select: #hasLinks)
		flatCollect: [ :method | (method ast allChildren collect: #links thenReject: #isNil) flatten ]