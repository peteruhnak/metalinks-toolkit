tests
testUnsubscribe
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: installer).
	installer unsubscribeFromSystemAnnouncer.
	self deny: (SystemAnnouncer uniqueInstance hasSubscriber: installer)