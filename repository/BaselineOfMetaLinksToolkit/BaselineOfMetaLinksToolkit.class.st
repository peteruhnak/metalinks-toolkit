"
I am a baseline for https://github.com/peteruhnak/metalinks-toolkit
"
Class {
	#name : #BaselineOfMetaLinksToolkit,
	#superclass : #BaselineOf,
	#category : 'BaselineOfMetaLinksToolkit'
}

{ #category : #baseline }
BaselineOfMetaLinksToolkit >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'MetaLinks-Toolkit'.
			spec group: 'default' with: #('MetaLinks-Toolkit') ]
]
