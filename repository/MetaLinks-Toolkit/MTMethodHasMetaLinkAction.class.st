"
I show an action when the method has MetaLink installed somewhere to it.
"
Class {
	#name : #MTMethodHasMetaLinkAction,
	#superclass : #AbstractMethodIconAction,
	#category : 'MetaLinks-Toolkit-Utility'
}

{ #category : #order }
MTMethodHasMetaLinkAction >> actionOrder [
	"Return the priority of this action"

	^ 0
]

{ #category : #order }
MTMethodHasMetaLinkAction >> allLinksInMethod: aMethod [
	^ (aMethod ast allChildren collect: #links) reject: #isNil
]

{ #category : #order }
MTMethodHasMetaLinkAction >> isActionHandled [
	"Return true if the provided method fits this action requirement"

	^ method hasLinks and: [ (self allLinksInMethod: method) isNotEmpty ]
]

{ #category : #order }
MTMethodHasMetaLinkAction >> privateActionIcon [
	"Return the icon for this action"

	^ IconicButton new
		target: [ :aMethod | (self allLinksInMethod: aMethod) inspect ];
		actionSelector: #value:;
		arguments: {method};
		labelGraphic: (Smalltalk ui icons iconNamed: #breakpoint);
		color: Color transparent;
		helpText: 'Inspect MetaLinks';
		extent: self iconExtent;
		borderWidth: 0
]
