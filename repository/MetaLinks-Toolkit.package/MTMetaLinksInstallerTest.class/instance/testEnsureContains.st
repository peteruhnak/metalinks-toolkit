tests
testEnsureContains
	| ast m1 m2 |
	m1 := MetaLink new.
	m2 := MetaLink new.
	ast := (target class >> #name) ast.
	self assert: ast links equals: nil.
	installer ensureNode: ast containsLink: m1.
	self set: ast links equals: {m1}.
	self assert: (target class >> #name) reflectiveMethod linkCount equals: 1.
	installer ensureNode: ast containsLink: m1.
	self set: ast links equals: {m1}.
	self assert: (target class >> #name) reflectiveMethod linkCount equals: 1.
	installer ensureNode: ast containsLink: m2.
	self set: ast links equals: (Set with: m1 with: m2).
	self assert: (target class >> #name) reflectiveMethod linkCount equals: 2