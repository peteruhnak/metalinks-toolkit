adding
addLink: aOneArgBlock
	| link |
	link := MTMetaLinkUser new.
	aOneArgBlock value: link.
	links add: link