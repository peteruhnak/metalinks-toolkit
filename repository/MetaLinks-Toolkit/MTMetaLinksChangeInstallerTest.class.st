Class {
	#name : #MTMetaLinksChangeInstallerTest,
	#superclass : #TestCase,
	#instVars : [
		'installer',
		'observation',
		'executed',
		'container',
		'element'
	],
	#category : 'MetaLinks-Toolkit-Tests'
}

{ #category : #tests }
MTMetaLinksChangeInstallerTest >> newContainerObservation [
	^ MTObservationSet
		target: MTContainer
		change: #(elements)
		add: #(add:)
		remove: #(remove:)
]

{ #category : #running }
MTMetaLinksChangeInstallerTest >> setUp [
	super setUp.
	installer := MTMetaLinksChangeInstaller new.
	container := MTContainer new.
	element := MTElement new
]

{ #category : #running }
MTMetaLinksChangeInstallerTest >> tearDown [
	super tearDown.
	installer installer uninstallAllPermanentLinksIn: MTElement.
	installer installer uninstallAllPermanentLinksIn: MTContainer
]

{ #category : #tests }
MTMetaLinksChangeInstallerTest >> testAddObserver [
	self deny: (MTContainer >> #add:) hasLinks.
	installer installAddObserverFor: #add: to: MTContainer.
	self assert: (MTContainer >> #add:) linkCount equals: 1.
	container when: ValueAdded do: [ :evt | executed := evt newValue ].
	self assert: executed equals: nil.
	container add: element.
	self assert: executed equals: element
]

{ #category : #tests }
MTMetaLinksChangeInstallerTest >> testChangeObserver [
	self deny: (MTElement >> #name:) hasLinks.
	installer installChangeObserverFor: #name to: MTElement.
	self assert: (MTElement >> #name:) linkCount equals: 1.
	element when: ValueChanged do: [ :evt | executed := evt newValue ].
	self assert: executed equals: nil.
	element name: 'new name'.
	self assert: executed equals: 'new name'
]

{ #category : #tests }
MTMetaLinksChangeInstallerTest >> testDifferentObjectBlock [
	installer changeMetaObjectBlock: [ :obj :args | executed := #change ].
	installer addMetaObjectBlock: [ :obj :args | executed := #add ].
	installer removeMetaObjectBlock: [ :obj :args | executed := #remove ].
	installer installChangeObserverFor: #name to: MTElement.
	installer installAddObserverFor: #add: to: MTContainer.
	installer installRemoveObserverFor: #remove: to: MTContainer.
	self assert: executed equals: nil.
	element name: 'new name'.
	self assert: executed equals: #change.
	container add: element.
	self assert: executed equals: #add.
	container remove: element.
	self assert: executed equals: #remove
]

{ #category : #tests }
MTMetaLinksChangeInstallerTest >> testExample [
	installer class example
]

{ #category : #tests }
MTMetaLinksChangeInstallerTest >> testInstallObservation [
	observation := self newContainerObservation.
	self deny: (MTContainer >> #add:) hasLinks.
	self deny: (MTContainer >> #remove:) hasLinks.
	installer installObservation: observation.
	self assert: (MTContainer >> #add:) hasLinks.
	self assert: (MTContainer >> #remove:) hasLinks
]

{ #category : #tests }
MTMetaLinksChangeInstallerTest >> testInstallObservations [
	self deny: (MTElement >> #name:) hasLinks.
	self deny: (MTContainer >> #add:) hasLinks.
	installer
		install:
			{MTObservationSet new
				target: MTElement;
				change: #(name).
			MTObservationSet new
				target: MTContainer;
				add: #(add:)}.
	self assert: (MTElement >> #name:) hasLinks.
	self assert: (MTContainer >> #add:) hasLinks
]

{ #category : #tests }
MTMetaLinksChangeInstallerTest >> testRemoveObserver [
	self deny: (MTContainer >> #remove:) hasLinks.
	installer installRemoveObserverFor: #remove: to: MTContainer.
	self assert: (MTContainer >> #remove:) linkCount equals: 1.
	container add: element.
	container when: ValueRemoved do: [ :evt | executed := evt oldValue ].
	self assert: executed equals: nil.
	container remove: element.
	self assert: executed equals: element
]
