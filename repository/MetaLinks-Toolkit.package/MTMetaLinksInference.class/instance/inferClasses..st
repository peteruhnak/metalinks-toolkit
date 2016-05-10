inferring
inferClasses: classes
	^ (classes collect: [ :each | each -> (self inferClass: each) ]) asDictionary