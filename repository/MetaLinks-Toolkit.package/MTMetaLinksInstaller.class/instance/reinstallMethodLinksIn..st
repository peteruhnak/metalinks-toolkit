reinstalling
reinstallMethodLinksIn: aMethod
	(self methodLinksAt: aMethod methodClass at: aMethod selector)
		do: [ :link | self ensureNode: aMethod ast containsLink: link ]