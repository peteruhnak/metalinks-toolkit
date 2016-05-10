instance creation
fromAssociation: anAssociation
	^ self
		target: anAssociation key
		change: (anAssociation value asDictionary at: #change ifAbsent: [ #() ])
		add: (anAssociation value asDictionary at: #add ifAbsent: [ #() ])
		remove: (anAssociation value asDictionary at: #remove ifAbsent: [ #() ])