"
I install the provided metalink to methods and reinstall them if the method has changed.

## Installing Links

I have two primary entry points:

* `installPermanent:toAttribute:of:`

Which will keep the metalink installed in all `AssignmentNode`s EXCEPT for #initialization method.
This means that if you add a new method that assigns to the attribute, the MetaLink will be automatically installed.

* `installPermanent:toMethod:of:`

This will install the MetaLink to a single method (or rather a selector) and will keep it there even on change, or removal & addition.

## Uninstalling Links

To uninstall all links use

`uninstallAllPermanentLinksIn:`

If you just need to wipe all metalinks in a class without removing the permanent feature, you can use `uninstallAllLinksIn:`.
"
Class {
	#name : #MTMetaLinksInstaller,
	#superclass : #Object,
	#instVars : [
		'attributeLinks',
		'methodLinks',
		'ignoredSelectors'
	],
	#category : 'MetaLinks-Toolkit'
}

{ #category : #accessing }
MTMetaLinksInstaller class >> allLinksIn: aClass [
	^ self basicNew allLinksIn: aClass
]

{ #category : #destroy }
MTMetaLinksInstaller class >> destroyAllLinksEverywhereFor: aClass [
	MTMetaLinksInstaller allInstances
		do: [ :each | each uninstallAllPermanentLinksIn: aClass ]
]

{ #category : #example }
MTMetaLinksInstaller class >> example [
	<playgroundExample>
| el installer link |
el := MTElement new.
"inspect announcer > announcements tab"
el.

installer := MTMetaLinksInstaller new.
installer uninstallAllLinksIn: MTElement.

link := MetaLink new
	metaObject: [ :object :newValue |
		object announcer announce: (ValueChanged newValue: newValue)
	];
	selector: #value:value:;
	arguments: #(object newValue);
	control: #after.

installer uninstallAllPermanentLinksIn: MTElement.
installer installPermanent: link toAttribute: #name of: MTElement.
el name: 'changed value'.
el class compile: 'resetName
	name := ''some default value'''.

el resetName.
]

{ #category : #accessing }
MTMetaLinksInstaller >> allLinksIn: aClass [
	^ (aClass methods select: #hasLinks)
		flatCollect:
			[ :method | (method ast allChildren collect: #links thenReject: #isNil) flatCollect: #yourself ]
]

{ #category : #accessing }
MTMetaLinksInstaller >> assignmentNodesOf: anAttribute in: aClass [
	^ aClass assignmentNodes
		select: [ :each | 
			each variable name = anAttribute
				and: [ (ignoredSelectors includes: each methodNode method selector) not ] ]
]

{ #category : #accessing }
MTMetaLinksInstaller >> attributeLinksAt: aClass at: aName [
	^ self linksIn: attributeLinks at: aClass at: aName
]

{ #category : #linking }
MTMetaLinksInstaller >> ensureNode: aNode containsLink: aMetaLink [
	(aNode links isNil or: [ (aNode links includes: aMetaLink) not ])
		ifTrue: [ aNode link: aMetaLink ]
]

{ #category : #initialization }
MTMetaLinksInstaller >> initialize [
	super initialize.
	attributeLinks := Dictionary new.
	methodLinks := Dictionary new.
	ignoredSelectors := #(initialize).
	self registerToSystemAnnouncer
]

{ #category : #installing }
MTMetaLinksInstaller >> installPermanent: aLink toAttribute: aName of: aClass [
	self
		linksIn: attributeLinks
		at: aClass
		at: aName
		add: aLink.
	(self assignmentNodesOf: aName in: aClass) do: [ :each | each link: aLink ]
]

{ #category : #installing }
MTMetaLinksInstaller >> installPermanent: aLink toMethod: aName of: aClass [
	self
		linksIn: methodLinks
		at: aClass
		at: aName
		add: aLink.
	(aClass >> aName) ast link: aLink
]

{ #category : #accessing }
MTMetaLinksInstaller >> linksIn: aStorage at: aClass at: aName [
	aStorage at: aClass ifAbsent: [ ^ #() ].
	^ (aStorage at: aClass) at: aName ifAbsent: [ #() ]
]

{ #category : #accessing }
MTMetaLinksInstaller >> linksIn: aStorage at: aClass at: aName add: aLink [
	^ ((aStorage at: aClass ifAbsentPut: [ Dictionary new ])
		at: aName
		ifAbsentPut: [ OrderedCollection new ]) add: aLink
]

{ #category : #'system announcements' }
MTMetaLinksInstaller >> methodAdded: aMethodAdded [
	self reinstallAttributeLinksIn: aMethodAdded method.
	self reinstallMethodLinksIn: aMethodAdded method
]

{ #category : #accessing }
MTMetaLinksInstaller >> methodLinksAt: aClass at: aName [
	^ self linksIn: methodLinks at: aClass at: aName
]

{ #category : #'system announcements' }
MTMetaLinksInstaller >> methodModified: aMethodModified [
	self reinstallAttributeLinksIn: aMethodModified method.
	self reinstallMethodLinksIn: aMethodModified method
]

{ #category : #'system announcements' }
MTMetaLinksInstaller >> methodRemoved: aMethodRemoved [
	"do nothing"
]

{ #category : #'system announcements' }
MTMetaLinksInstaller >> registerToSystemAnnouncer [
	SystemAnnouncer uniqueInstance weak
		when: MethodAdded send: #methodAdded: to: self;
		when: MethodModified send: #methodModified: to: self;
		when: MethodRemoved send: #methodRemoved: to: self
]

{ #category : #reinstalling }
MTMetaLinksInstaller >> reinstallAttributeLinksIn: aMethod [
	(ignoredSelectors includes: aMethod selector)
		ifTrue: [ ^ self ].
	aMethod assignmentNodes
		ifNotNil: [ :nodes | 
			nodes
				do: [ :assignment | 
					(self attributeLinksAt: aMethod methodClass at: assignment variable name)
						do: [ :link | self ensureNode: assignment containsLink: link ] ] ]
]

{ #category : #reinstalling }
MTMetaLinksInstaller >> reinstallMethodLinksIn: aMethod [
	(self methodLinksAt: aMethod methodClass at: aMethod selector)
		do: [ :link | self ensureNode: aMethod ast containsLink: link ]
]

{ #category : #uninstalling }
MTMetaLinksInstaller >> uninstallAllLinksIn: aClass [
	(self allLinksIn: aClass) do: #uninstall
]

{ #category : #uninstalling }
MTMetaLinksInstaller >> uninstallAllPermanentLinksIn: aClass [
	attributeLinks
		at: aClass
		ifPresent: [ :dicts | 
			dicts valuesDo: [ :col | col do: #uninstall ].
			dicts removeAll.
			attributeLinks removeKey: aClass ].
	methodLinks
		at: aClass
		ifPresent: [ :dicts | 
			dicts valuesDo: [ :col | col do: #uninstall ].
			dicts removeAll.
			methodLinks removeKey: aClass ].
	self uninstallAllLinksIn: aClass
]

{ #category : #uninstalling }
MTMetaLinksInstaller >> uninstallAttribute: aName of: aClass [
	self uninstallFrom: attributeLinks at: aName at: aClass
]

{ #category : #uninstalling }
MTMetaLinksInstaller >> uninstallFrom: aStorage at: aName at: aClass [
	aStorage
		at: aClass
		ifPresent: [ :dict | 
			dict
				at: aName
				ifPresent: [ :links | 
					links do: #uninstall.
					dict removeKey: aName ].
			dict ifEmpty: [ aStorage removeKey: aClass ] ]
]

{ #category : #uninstalling }
MTMetaLinksInstaller >> uninstallMethod: aName of: aClass [
	self uninstallFrom: methodLinks at: aName at: aClass
]

{ #category : #'system announcements' }
MTMetaLinksInstaller >> unsubscribeFromSystemAnnouncer [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
