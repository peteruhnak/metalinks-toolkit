inferring - private
removalsIn: aClass
	^ (self instanceMessagesIn: aClass)
		select: [ :each | each selector = #remove: ]
		thenCollect: #selector