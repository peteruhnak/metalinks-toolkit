"
I open class-side examples marked with <plagroundExample> in Playground instead of directly executing them.
"
Class {
	#name : #MTPlaygroundExampleAction,
	#superclass : #AbstractMethodIconAction,
	#category : 'MetaLinks-Toolkit-Utility'
}

{ #category : #'as yet unclassified' }
MTPlaygroundExampleAction >> actionOrder [
	"Return the priority of this action"

	^ -1
]

{ #category : #'as yet unclassified' }
MTPlaygroundExampleAction >> isActionHandled [
	"Return true if the provided method fits this action requirement"

	^ method pragmas anySatisfy: [ :each | each keyword = 'playgroundExample' ]
]

{ #category : #'as yet unclassified' }
MTPlaygroundExampleAction >> privateActionIcon [
	"Return the icon for this action"

	^ IconicButton new
		target: [ :aMethod | 
			GTPlayground
				openContents: (aMethod ast body source atAll: aMethod ast body sourceInterval)
				label: aMethod methodClass className , '>>#' , aMethod selector ];
		actionSelector: #value:;
		arguments: {method};
		labelGraphic: (Smalltalk ui icons iconNamed: #glamorousPlay);
		color: Color transparent;
		helpText: 'Open Example in Playground';
		extent: self iconExtent;
		borderWidth: 0
]
