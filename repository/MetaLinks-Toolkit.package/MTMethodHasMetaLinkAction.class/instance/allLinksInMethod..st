order
allLinksInMethod: aMethod
	^ (aMethod ast allChildren collect: #links) reject: #isNil