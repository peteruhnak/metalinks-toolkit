inferring - private
instanceMessagesIn: aClass
	| vars messages |
	vars := self instanceVariablesIn: aClass.
	messages := aClass methods
		flatCollect: [ :each | each ast allChildren select: #isMessage ].
	^ messages
		select: [ :each | each receiver isVariable and: [ vars includes: each receiver name ] ]