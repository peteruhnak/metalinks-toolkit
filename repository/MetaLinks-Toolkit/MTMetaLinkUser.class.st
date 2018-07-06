Class {
	#name : #MTMetaLinkUser,
	#superclass : #Object,
	#instVars : [
		'target',
		'link'
	],
	#category : 'MetaLinks-Toolkit'
}

{ #category : #accessing }
MTMetaLinkUser >> action: aBlock [
	self link metaObject: aBlock.
	self arguments: aBlock argumentNames
]

{ #category : #accessing }
MTMetaLinkUser >> arguments: aCollection [
	link arguments: aCollection.
	link selector: (#value: repeat: aCollection size)
]

{ #category : #accessing }
MTMetaLinkUser >> control: aControl [
	^ self link control: aControl
]

{ #category : #initialization }
MTMetaLinkUser >> initialize [
	super initialize.
	(link := MetaLink new)
		metaObject: [ :object |  ];
		selector: #value:;
		arguments: #(object);
		control: #after
]

{ #category : #actions }
MTMetaLinkUser >> install [
	target link: link
]

{ #category : #accessing }
MTMetaLinkUser >> link [
	^ link
]

{ #category : #accessing }
MTMetaLinkUser >> target [
	^ target
]

{ #category : #accessing }
MTMetaLinkUser >> target: anAstNode [
	target := anAstNode isCompiledMethod | (anAstNode isKindOf: ReflectiveMethod)
		ifTrue: [ anAstNode ast ]
		ifFalse: [ anAstNode ]
]

{ #category : #actions }
MTMetaLinkUser >> uninstall [
	(target links isNotNil and: [ target links isNotEmpty ])
		ifTrue: [ target links do: #uninstall ]
]
