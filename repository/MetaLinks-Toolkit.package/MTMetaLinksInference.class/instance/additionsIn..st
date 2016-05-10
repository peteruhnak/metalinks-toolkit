inferring - private
additionsIn: aClass
	^ (self instanceMessagesIn: aClass)
		select: [ :each | each selector = #add: ]
		thenCollect: #selector