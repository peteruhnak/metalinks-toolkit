order
privateActionIcon
	"Return the icon for this action"

	^ IconicButton new
		target: [ :aMethod | ((aMethod ast allChildren collect: #links) reject: #isNil) flatten inspect ];
		actionSelector: #value:;
		arguments: {method};
		labelGraphic: (Smalltalk ui icons iconNamed: #breakpoint);
		color: Color transparent;
		helpText: 'Inspect MetaLinks';
		extent: self iconExtent;
		borderWidth: 0