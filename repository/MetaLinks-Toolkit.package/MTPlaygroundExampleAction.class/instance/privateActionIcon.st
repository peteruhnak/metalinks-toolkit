as yet unclassified
privateActionIcon
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