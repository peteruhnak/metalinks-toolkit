Class {
	#name : #MTMetaLinkRegistration,
	#superclass : #Object,
	#instVars : [
		'links'
	],
	#category : 'MetaLinks-Toolkit'
}

{ #category : #adding }
MTMetaLinkRegistration >> addLink: aOneArgBlock [
	| link |
	link := MTMetaLinkUser new.
	aOneArgBlock value: link.
	links add: link
]

{ #category : #initialization }
MTMetaLinkRegistration >> initialize [
	super initialize.
	links := OrderedCollection new
]

{ #category : #actions }
MTMetaLinkRegistration >> install [
	self uninstall.
	links do: #install
]

{ #category : #actions }
MTMetaLinkRegistration >> uninstall [
	links do: #uninstall
]
