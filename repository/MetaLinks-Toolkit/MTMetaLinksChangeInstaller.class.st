"
I take observations for classes as input and install announcement-based metalinks.

The change/add/remove behavior is pluggable, so you can specify what should happen.

The observation can be an instance of MTObservationSet or a simple association array/Dictionary.

!! Example

see class-side
"
Class {
	#name : #MTMetaLinksChangeInstaller,
	#superclass : #Object,
	#instVars : [
		'installer',
		'addMetaObjectBlock',
		'removeMetaObjectBlock',
		'changeMetaObjectBlock'
	],
	#category : 'MetaLinks-Toolkit'
}

{ #category : #example }
MTMetaLinksChangeInstaller class >> example [
	<playgroundExample>
| observations ci el c |
observations := {
	MTObservationSet
		target: MTElement
		change: #(name owner uuid)
		add: #()
		remove: #().

	MTObservationSet
		target: MTContainer
		change: #()
		add: #(add:)
		remove: #(remove:)
}.
ci := MTMetaLinksChangeInstaller new.
ci installer uninstallAllPermanentLinksIn: MTElement.
ci installer uninstallAllPermanentLinksIn: MTContainer.
ci install: observations.
el := MTElement new.
c := MTContainer new.

"Inspect both instances and look at announcements of their announcers."
el.
c.

el name: 'new name'.
c add: el.
c remove: el
]

{ #category : #accessing }
MTMetaLinksChangeInstaller >> addMetaObjectBlock: aTwoArgBlock [
	"A block [ :object :arguments | ], where `object` is the observed object, and `arguments` the arguments provided to the method"

	addMetaObjectBlock := aTwoArgBlock
]

{ #category : #accessing }
MTMetaLinksChangeInstaller >> changeMetaObjectBlock: aTwoArgBlock [
	"A block [ :object :newValue | ], where `object` is the observed object, and `newValue` the newly assigned value."

	changeMetaObjectBlock := aTwoArgBlock
]

{ #category : #initialization }
MTMetaLinksChangeInstaller >> initialize [
	super initialize.
	installer := MTMetaLinksInstaller new.
	changeMetaObjectBlock := [ :object :newValue | object announcer announce: (ValueChanged newValue: newValue) ].
	addMetaObjectBlock := [ :object :arguments | object announcer announce: (ValueAdded newValue: arguments first) ].
	removeMetaObjectBlock := [ :object :arguments | object announcer announce: (ValueRemoved new oldValue: arguments first) ]
]

{ #category : #installing }
MTMetaLinksChangeInstaller >> install: observations [
	observations do: [ :each | self installObservation: each ]
]

{ #category : #'installing - private' }
MTMetaLinksChangeInstaller >> installAddObserverFor: aSymbol to: aClass [
	| link |
	link := MetaLink new
		metaObject: addMetaObjectBlock;
		selector: #value:value:;
		arguments: #(object arguments);
		control: #after.
	installer installPermanent: link toMethod: aSymbol of: aClass
]

{ #category : #'installing - private' }
MTMetaLinksChangeInstaller >> installChangeObserverFor: aSymbol to: aClass [
	| link |
	link := MetaLink new
		metaObject: changeMetaObjectBlock;
		selector: #value:value:;
		arguments: #(object newValue);
		control: #after.
	installer installPermanent: link toAttribute: aSymbol of: aClass
]

{ #category : #installing }
MTMetaLinksChangeInstaller >> installObservation: anObservation [
	anObservation change
		do: [ :each | self installChangeObserverFor: each to: anObservation target ].
	anObservation add
		do: [ :each | self installAddObserverFor: each to: anObservation target ].
	anObservation remove
		do: [ :each | self installRemoveObserverFor: each to: anObservation target ]
]

{ #category : #'installing - private' }
MTMetaLinksChangeInstaller >> installRemoveObserverFor: aSymbol to: aClass [
	| link |
	link := MetaLink new
		metaObject: removeMetaObjectBlock;
		selector: #value:value:;
		arguments: #(object arguments);
		control: #after.
	installer installPermanent: link toMethod: aSymbol of: aClass
]

{ #category : #accessing }
MTMetaLinksChangeInstaller >> installer [
	^ installer
]

{ #category : #accessing }
MTMetaLinksChangeInstaller >> removeMetaObjectBlock: aTwoArgBlock [
	"A block [ :object :arguments | ], where `object` is the observed object, and `arguments` the arguments provided to the method"

	removeMetaObjectBlock := aTwoArgBlock
]
