"
I am a dummy target for MetaLinks installer tests.
"
Class {
	#name : #MTElement,
	#superclass : #Object,
	#instVars : [
		'name',
		'owner',
		'announcer',
		'uuid'
	],
	#category : 'MetaLinks-Toolkit-Tests'
}

{ #category : #announcements }
MTElement >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #announcements }
MTElement >> announcer [
	^ announcer
]

{ #category : #announcements }
MTElement >> announcer: anObject [
	announcer := anObject
]

{ #category : #initialization }
MTElement >> initialize [
	super initialize.
	announcer := Announcer new.
	name := ''.
	uuid := UUID new
]

{ #category : #accessing }
MTElement >> name [
	^ name
]

{ #category : #accessing }
MTElement >> name: aString [
	name := aString
]

{ #category : #accessing }
MTElement >> owner [
	^ owner
]

{ #category : #accessing }
MTElement >> owner: anElement [
	owner := anElement
]

{ #category : #announcements }
MTElement >> silentlyDo: aBlock [
	| oldAnnouncer |
	oldAnnouncer := self announcer.
	self announcer: Announcer new.
	aBlock value.
	self announcer: oldAnnouncer
]

{ #category : #accessing }
MTElement >> uuid [
	^ uuid
]

{ #category : #accessing }
MTElement >> uuid: aUUID [
	uuid := aUUID
]

{ #category : #announcements }
MTElement >> when: anAnnouncementClass do: aValuable [
	self announcer when: anAnnouncementClass do: aValuable
]

{ #category : #announcements }
MTElement >> when: anAnnouncementClass send: aSelector to: anObject [
	^ self announcer when: anAnnouncementClass send: aSelector to: anObject
]
